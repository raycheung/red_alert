defmodule RedAlert do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      worker(RedAlert.Monitor, [stash]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RedAlert.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defdelegate snooze(tag), to: RedAlert.Monitor

  defp stash do
    {:ok, agent} = RedAlert.Stash.start_link
    agent
  end
end
