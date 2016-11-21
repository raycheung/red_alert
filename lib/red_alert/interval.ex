defmodule RedAlert.Interval do
  @a_minute 60
  @a_day 24 * 60 * @a_minute
  @options [
    every_15mins: 15 * @a_minute,
    every_30mins: 30 * @a_minute,
    every_1hour:  60 * @a_minute,
    every_1day:   @a_day,
    every_7days:  7 * @a_day,
  ]
  if Mix.env in ~w(dev test)a, do: @options [{:every_1sec, 1}, {:every_5secs, 5}, {:every_30secs, 30} | @options]

  @doc ~S"Get available all interval options"
  def options, do: Keyword.keys(@options)

  @doc ~S"Get the equipvalent `interval` in term of seconds"
  def get(interval), do: Keyword.get(@options, interval)
end
