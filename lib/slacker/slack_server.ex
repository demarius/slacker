defmodule Slacker.SlackServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, self, name: __MODULE__)
  end

  def init (pid) do
    {:ok, slack_pid} = Slacker.Slack.start_link(Application.get_env(:slacker, :slack_token))
  end
end
