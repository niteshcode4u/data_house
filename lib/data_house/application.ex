defmodule DataHouse.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  alias DataHouse.Services.Publisher
  alias DataHouse.Services.Subscribers.DielectronSubscriber
  alias DataHouse.Services.Subscribers.MemeSubscriber
  alias DataHouse.Services.Subscribers.TwitchdataSubscriber

  @redis_host Application.compile_env!(:data_house, :redix)[:host]
  @redis_port Application.compile_env!(:data_house, :redix)[:port]

  @impl true
  def start(_type, _args) do
    children = [
      DataHouse.Repo,
      %{id: Publisher, start: {Publisher, :start_link, []}},
      DielectronSubscriber,
      MemeSubscriber,
      TwitchdataSubscriber,
      {Redix, host: @redis_host, port: @redis_port, name: :redix},
      DataHouseWeb.Telemetry,
      {Phoenix.PubSub, name: DataHouse.PubSub},
      DataHouseWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DataHouse.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DataHouseWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
