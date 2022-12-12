defmodule Murad.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Murad.Repo,
      # Start the Telemetry supervisor
      MuradWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Murad.PubSub},
      # Start the Endpoint (http/https)
      MuradWeb.Endpoint
      # Start a worker by calling: Murad.Worker.start_link(arg)
      # {Murad.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Murad.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MuradWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
