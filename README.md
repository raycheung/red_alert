# RedAlert

Monitor events that do **NOT** happen in designated schedule.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `red_alert` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:red_alert, "~> 0.1.0"}]
    end
    ```

  2. Ensure `red_alert` is started before your application:

    ```elixir
    def application do
      [applications: [:red_alert]]
    end
    ```

