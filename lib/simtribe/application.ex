defmodule SimTribe.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SimTribeWeb.Telemetry,
      # Start the Ecto repository
      SimTribe.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: SimTribe.PubSub},
      # Start Finch
      {Finch, name: SimTribe.Finch},
      # Start the Endpoint (http/https)
      SimTribeWeb.Endpoint
      # Start a worker by calling: SimTribe.Worker.start_link(arg)
      # {SimTribe.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SimTribe.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SimTribeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
