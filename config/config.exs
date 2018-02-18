# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tasktrack,
  namespace: TaskTrack,
  ecto_repos: [TaskTrack.Repo]

# Configures the endpoint
config :tasktrack, TaskTrackWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "tv+lFh5Kkw5OaOifJ7c9F+b9+YACs1+QCKj3EP6qhWcgbjykD+TwejEWMweddpas",
  render_errors: [view: TaskTrackWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TaskTrack.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
