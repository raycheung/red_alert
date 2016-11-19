defmodule RedAlert.TimeHelper do
  @doc ~S"Get the current time"
  def now, do: Timex.now

  @doc ~S"Check if the `time` with `seconds` later is in the past."
  def passed?(time, seconds), do: time |> Timex.shift(seconds: seconds) |> Timex.before?(now)
end
