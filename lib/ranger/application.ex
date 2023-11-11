defmodule Ranger.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      RangerWeb.Telemetry,
      Ranger.Repo,
      {DNSCluster, query: Application.get_env(:ranger, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Ranger.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Ranger.Finch},
      # Start a worker by calling: Ranger.Worker.start_link(arg)
      # {Ranger.Worker, arg},
      # Start to serve requests, typically the last entry
      RangerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Ranger.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    RangerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
