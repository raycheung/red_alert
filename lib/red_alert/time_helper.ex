defmodule RedAlert.TimeHelper do
  def now, do: Timex.now

  def passed?(time, seconds), do: time |> Timex.shift(seconds: seconds) |> Timex.before?(now)
end
