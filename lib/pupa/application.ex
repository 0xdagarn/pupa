defmodule Pupa.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      PupaWeb.Telemetry,
      # Start the Ecto repository
      Pupa.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pupa.PubSub},
      # Start Finch
      {Finch, name: Pupa.Finch},
      # Start the Endpoint (http/https)
      PupaWeb.Endpoint
      # Start a worker by calling: Pupa.Worker.start_link(arg)
      # {Pupa.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pupa.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PupaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
