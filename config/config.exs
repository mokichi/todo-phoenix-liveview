# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :todo_phoenix_liveview,
  ecto_repos: [TodoPhoenixLiveview.Repo]

# Configures the endpoint
config :todo_phoenix_liveview, TodoPhoenixLiveviewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "FDtrW38ddyCs+AA+wIIDMXul8pmp1mD2gNF3B4fQV5khDIs0g7pSrP50NSdWZIio",
  render_errors: [view: TodoPhoenixLiveviewWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: TodoPhoenixLiveview.PubSub,
  live_view: [signing_salt: "xf2e4nTG"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
