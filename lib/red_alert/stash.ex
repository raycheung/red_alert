defmodule RedAlert.Stash do
  import RedAlert.TimeHelper

  @doc ~S"Start a stash"
  def start_link, do: Agent.start_link(fn -> [] end, name: __MODULE__)

  @doc ~S"Record the current time for `tag` in the provided `stash`"
  def record_time(stash, tag) do
    Agent.update stash, fn s ->
      Keyword.put s, tag, now
    end
  end

  @doc ~S"Get from the provided `stash`"
  def get(stash), do: Agent.get(stash, &(&1))
end
