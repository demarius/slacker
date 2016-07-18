# Slacker

Slack bot to send a message every day.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `slacker` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:slacker, "~> 0.1.0"}]
    end
    ```

  2. Ensure `slacker` is started before your application:

    ```elixir
    def application do
      [applications: [:slacker]]
    end
    ```
