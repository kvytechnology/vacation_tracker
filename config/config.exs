# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :vacation_tracker,
  ecto_repos: [VacationTracker.Repo]

# Configures the endpoint
config :vacation_tracker, VacationTrackerWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "A+YgTGgfdimoAOrN1l8XCuryWuLYJWP9pbjA4o0klyET327QTAYQhNHFfHcMvZI/",
  render_errors: [view: VacationTrackerWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: VacationTracker.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :vacation_tracker, :slack,
  base_url: "https://slack.com",
  bot_token: System.get_env("SLACK_APP_TOKEN")

config :ueberauth, Ueberauth,
  providers: [
    google: {Ueberauth.Strategy.Google, []}
  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
