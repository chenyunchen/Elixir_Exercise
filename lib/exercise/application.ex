defmodule Exercise.Application do
  use Application
  require Logger

  def start(_type, _args) do
    children = [
      Plug.Cowboy.child_spec(
        scheme: :http,
        plug: Exercise.Router,
        options: [port: cowboy_port()]
      )
    ]
    opts = [strategy: :one_for_one, name: Exercise.Supervisor]

    Logger.info("Starting application...")

    Supervisor.start_link(children, opts)
  end

  defp cowboy_port, do: Application.get_env(:exercise, :cowboy_port, 8080)
end
