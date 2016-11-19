defmodule RedAlert.Monitor do
  use GenServer
  import RedAlert.TimeHelper
  alias RedAlert.Stash
  alias RedAlert.Interval
  require Logger

  @doc "Start the monitor with the provided `stash`"
  def start_link(stash) when is_pid(stash), do: GenServer.start_link(__MODULE__, [stash: stash], name: __MODULE__)

  @schedules Application.get_env(:red_alert, :schedules, [])
  @notify_list Application.get_env(:red_alert, :notify, [])
  def init(state) do
    timer = {:timer, Task.async(RedAlert.Timer, :loop, [&wake/0])}
    notify = {:notify, [(&notify/1) | @notify_list]}
    {:ok, [{:schedules, @schedules}, timer, notify | state]}
  end

  def handle_call({:snooze, tag}, _from, state) do
    case Map.fetch(state[:schedules], tag) do
      {:ok, _} ->
        initial_snooze = Stash.record_time(state[:stash], tag)
        if initial_snooze, do: notify_all([{tag, state[:schedules][tag]}], state[:notify])
        {:reply, :ok, state}
      :error -> {:reply, :error, state}
    end
  end

  def handle_cast(:wake, state) do
    Logger.debug "Wake"
    last_snoozed = Stash.get(state[:stash])

    state[:schedules]
    |> filter_expired(last_snoozed)
    |> notify_all(state[:notify])

    {:noreply, state}
  end

  @doc ~S"Snooze for the `tag` to suppress the alert."
  def snooze(tag), do: GenServer.call(__MODULE__, {:snooze, tag})

  @doc ~S"Wake the monitor to check expired tags"
  def wake, do: GenServer.cast(__MODULE__, :wake)

  @doc ~S"Default notification function that prints a log message"
  def notify({tag, interval}), do: Logger.info "Initial check-in for #{tag}, which expect to snooze #{interval}"
  def notify({tag, interval, last_snoozed_at, missed_count}) do
    Logger.info "Expect #{tag} to snooze #{interval} but it missed. Last snoozed at #{last_snoozed_at}, has missed #{missed_count} cycles."
  end

  defp filter_expired(schedules, last_snoozed) do
    schedules
    |> Enum.zip(last_snoozed)
    |> Enum.map(fn {{t, i}, {t, l}} -> {t, i, l, count_cycles(Interval.get(i), l)} end)
    |> Enum.filter(&expired?/1)
  end

  defp expired?({_, _, _, 0}), do: false
  defp expired?(_), do: true

  defp count_cycles(seconds, since, acc \\ 0) do
    if !past?(since), do: acc, else: count_cycles(seconds, shift(since, seconds), acc + 1)
  end

  defp notify_all(n, funcs), do: Enum.each(n, fn t -> Enum.each(funcs, &(&1.(t))) end)
end
