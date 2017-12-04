# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bet_your_balls,
  ecto_repos: [BetYourBalls.Repo]

# Configures the endpoint
config :bet_your_balls, BetYourBallsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uWKIX2xsYfZwRnALT00cGMHl5LrQLwurQuPFzfvPBZAhgtMCYRGlc3XHQli3v2Fl",
  render_errors: [view: BetYourBallsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BetYourBalls.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :bet_your_balls,
  pug: PhoenixExpug.Engine

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: BetYourBalls.Core.User,
  repo: BetYourBalls.Repo,
  module: BetYourBalls,
  web_module: BetYourBallsWeb,
  router: BetYourBallsWeb.Router,
  messages_backend: BetYourBallsWeb.Coherence.Messages,
  logged_out_url: "/",
  opts: [:authenticatable]
# %% End Coherence Configuration %%
