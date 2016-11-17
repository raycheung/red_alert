# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :logger, level: :debug

config :logger, :console,
  format: "$time $metadata[$level] $levelpad$message\n",
  metadata: [:application, :module]

import_config "#{Mix.env}.exs"
