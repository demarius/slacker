defmodule Slacker do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      worker(Slacker.SlackServer, [])
    ]

    opts = [
      strategy: :one_for_one, name: Slacker.Supervisor
    ]

    Supervisor.start_link(children, opts)
  end
end
