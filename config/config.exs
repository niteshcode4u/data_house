# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :data_house,
  ecto_repos: [DataHouse.Repo]

# Configures the endpoint
config :data_house, DataHouseWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: DataHouseWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: DataHouse.PubSub,
  live_view: [signing_salt: "doMnwiE6"]

config :data_house, :rabbit_mq,
  username: System.get_env("RMQ_USERNAME", "guest"),
  password: System.get_env("RMQ_PASSWORD", "guest"),
  port: System.get_env("RMQ_PORT", "5672") |> String.to_integer(),
  host: System.get_env("RMQ_HOST", "localhost")

config :data_house, :redix,
  host: System.get_env("REDIS_HOST", "localhost"),
  port: System.get_env("REDIS_PORT", "6379") |> String.to_integer()

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :data_house, DataHouse.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
