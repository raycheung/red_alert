defmodule RedAlert.TimeHelper do
  @doc ~S"Get the current time"
  def now, do: Timex.now

  @doc ~S"Check if the `time` with `seconds` later is in the past."
  def past?(time, seconds \\ 0), do: time |> shift(seconds) |> Timex.before?(now)

  @doc ~S"Move forward the `time` with `seconds`."
  def shift(time, seconds), do: Timex.shift(time, seconds: seconds)
end
