defmodule Deckz.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      DeckzWeb.Telemetry,
      # Start the Ecto repository
      Deckz.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Deckz.PubSub},
      # Start Finch
      {Finch, name: Deckz.Finch},
      # Start the Endpoint (http/https)
      DeckzWeb.Endpoint
      # Start a worker by calling: Deckz.Worker.start_link(arg)
      # {Deckz.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Deckz.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DeckzWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
