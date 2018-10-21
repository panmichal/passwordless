# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :passwordless_auth_web,
  namespace: PasswordlessAuthWeb

# Configures the endpoint
config :passwordless_auth_web, PasswordlessAuthWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PSaWk9rHIF+k4VBCkulk8BF7g004upNoBA7ykkVNKqg7qlvReBMLAxret85mM8FU",
  render_errors: [view: PasswordlessAuthWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: PasswordlessAuthWeb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :passwordless_auth_web, :generators,
  context_app: :passwordless_auth

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
