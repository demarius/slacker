defmodule Slacker.SlackServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, self, name: __MODULE__)
  end
end
