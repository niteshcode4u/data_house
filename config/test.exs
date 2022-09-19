import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :data_house, DataHouse.Repo,
  username: "root",
  password: "mauFJcuf5dhRMQrjj",
  database: "data_house_test",
  port: 3307,
  show_sensitive_data_on_connection_error: true,
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 5

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :data_house, DataHouseWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "/6t1WASmBqS4Ewl2ZdOf33dbHYnBUoDfKlvZ2xtjAH7Js69OOsAJL9jV86bBQHku",
  server: false

# In test we don't send emails.
config :data_house, DataHouse.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
