defmodule RedAlert.DummyProcess do
  @interval 5 * 1_000
  @hits [true, true, false]

  def start, do: @hits |> Stream.cycle |> Enum.each(&work/1)

  def work(hit) do
    Process.sleep @interval
    if hit, do: RedAlert.snooze __MODULE__
  end
end
