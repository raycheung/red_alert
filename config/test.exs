use Mix.Config

config :red_alert,
  schedules: %{RedAlert.DummyProcess => :every_1sec},
  notify: [&Notifier.notify/1]
