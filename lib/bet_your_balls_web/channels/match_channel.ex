defmodule BetYourBallsWeb.MatchChannel do
  use BetYourBallsWeb, :channel

  def join("match:" <> match_id, _params, socket) do
    {:ok, socket}
  end
end
