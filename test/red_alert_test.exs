defmodule RedAlertTest do
  use ExUnit.Case
  doctest RedAlert

  setup do
    Notifier.start_link
    :ok
  end

  def wait_for_message do
    with nil <- Notifier.pop, do: wait_for_message
  end

  test "notify function (`Notifier.notify/1`) is triggered when the alarm is not snoozed." do
    RedAlert.snooze RedAlert.DummyProcess

    assert {RedAlert.DummyProcess, :every_1sec} == wait_for_message

    missed_message = wait_for_message
    assert elem(missed_message, 0) == RedAlert.DummyProcess
    assert elem(missed_message, 1) == :every_1sec
    assert elem(missed_message, 2) != nil
    assert elem(missed_message, 3) == 1
  end
end
