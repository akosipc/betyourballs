defmodule BetYourBallsWeb.Api.MatchController do
  use BetYourBallsWeb, :controller

  alias BetYourBalls.Repo
  alias BetYourBalls.Core.Match

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Repo.get(Match, id)
    changeset = Match.changeset(match, match_params)

    case Repo.update(changeset) do
      {:ok, match} ->
        render(conn, "show.json", match: match)
      {:error, changeset} ->
        render(conn, "error.json", changeset: changeset)
    end
  end
end
