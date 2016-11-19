# RedAlert

Monitor events that do **NOT** happen in designated schedule.

## How it works

If you ever use cron-like scheduling tool you would have experienced this: it's very trivial to identify if a task/job run, basically you just need to check the log. However, it's not so if your expected event **didn't occur.** More than likely you would need to scan through the log of the entire period to check if it's delayed or missed.

RedAlert, inspired by [Dead Man's Snitch](https://deadmanssnitch.com), attempts to provide a very simple mechanism to give you a notification (by default a log message), that an event is missed.

## Installation

  1. Add `red_alert` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:red_alert, "~> 0.2.0"}]
    end
    ```

  2. Ensure `red_alert` is started before your application:

    ```elixir
    def application do
      [applications: [:red_alert]]
    end
    ```

## Configuration

  1. Define the `schedules` in your `config.exs`:

    ```elixir
    config :red_alert,
      schedules: %{AnyTag1 => :every_15mins, AnyTag2 => :every_1day},
      notify: [&Notifier.notify/1]
    ```
    Where:
      - `schedules`: The keys are the event `tags` you would call with [RedAlert.snooze/1](https://hexdocs.pm/red_alert/RedAlert.html#snooze/1), and the values are the corresponding intervals (available options found in `RedAlert.Interval`).
      - `notify`: Optional list of callback functions which would receive notifications. The default callback is [RedAlert.Monitor.notify/1](https://hexdocs.pm/red_alert/RedAlert.Monitor.html#notify/1).

  2. In your code that emits the event, add:

    ```elixir
    RedAlert.snooze AnyTag1
    ```
