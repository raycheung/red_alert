defmodule RedAlert.DummyProcess do
  @moduledoc ~S"""
  A dummy process to snooze the alert periodically, in a prescheduled hit and miss manner.
  """

  @interval 5 * 1_000
  @hits [true, true, false]

  def cycle, do: @hits |> Stream.cycle |> Enum.each(&do_cycle/1)

  defp do_cycle(hit) do
    Process.sleep @interval
    if hit, do: RedAlert.snooze __MODULE__
  end
end
