defmodule Notifier do
  def start_link, do: Agent.start_link(fn -> [] end, name: __MODULE__)

  def notify(message), do: Agent.update(__MODULE__, fn m -> m ++ [message] end)

  def pop do
    Agent.get_and_update __MODULE__, fn
      [] -> {nil, []}
      [h | tl] -> {h, tl}
    end
  end
end
