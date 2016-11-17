defmodule RedAlert.Stash do
  import RedAlert.TimeHelper

  def start_link, do: Agent.start_link(fn -> [] end, name: __MODULE__)

  def record_time(stash, tag) do
    Agent.update stash, fn s ->
      Keyword.put s, tag, now
    end
  end

  def get(stash), do: Agent.get(stash, &(&1))
end
