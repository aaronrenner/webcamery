# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :webcamery, Webcamery.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "XwFYytOF+7PwDXrmgqyfeezpstOXS/22Naby2l57qydsSsKNMs3TSyUYnnfuWYwL",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Webcamery.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure Guardian
config :guardian, Guardian,
  issuer: "Webcamery",
  ttl: {30, :days},
  secret_key: "XwFYytOF+7PwDXrmgqyfeezpstOXS/22Naby2l57qydsSsKNMs3TSyUYnnfuWYwL",
  serializer: Webcamery.GuardianSerializer

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false
