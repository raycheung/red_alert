defmodule RedAlert.Timer do
  @delay 5 * 1_000
  def loop(wake) when is_function(wake, 0) do
    Process.sleep(@delay)
    wake.()
    loop(wake)
  end
end
