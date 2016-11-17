use Mix.Config

config :red_alert,
  schedules: [{RedAlert.DummyProcess, :every_5secs}]
