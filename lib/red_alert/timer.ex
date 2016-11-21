defmodule RedAlert.Timer do
  @doc ~S"Trigger the provided `wake` function periodically."
  @delay 5 * 1_000
  if Mix.env == :test, do: @delay 1_000
  def loop(wake) when is_function(wake, 0) do
    Process.sleep(@delay)
    wake.()
    loop(wake)
  end
end
