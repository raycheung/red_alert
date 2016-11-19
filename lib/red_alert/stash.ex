defmodule RedAlert.Stash do
  import RedAlert.TimeHelper

  @doc ~S"Start a stash"
  def start_link, do: Agent.start_link(fn -> %{} end, name: __MODULE__)

  @doc ~S"""
  Record the current time for `tag` in the provided `stash`.

  The returned value is a tuple with a boolean indicating if it's the initial record in the stash.
  """
  def record_time(stash, tag) do
    Agent.get_and_update stash, fn s ->
      Map.get_and_update s, tag, fn curr -> {!curr, now} end
    end
  end

  @doc ~S"Get from the provided `stash`"
  def get(stash), do: Agent.get(stash, &(&1))
end
