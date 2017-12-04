defmodule BetYourBallsWeb.Api.MatchView do
  use BetYourBallsWeb, :view

  alias BetYourBallsWeb.Api.ApiView

  def render("show.json", %{match: match}) do
    %{
      match: render_one(match, BetYourBallsWeb.Api.MatchView, "match.json")
    }
  end

  def render("match.json", %{match: match}) do
    %{
      id: match.id,
      match_status: match.status
    }
  end

  def render("error.json", %{changeset: changeset}) do
    ApiView.render("error.json", changeset)
  end
end
