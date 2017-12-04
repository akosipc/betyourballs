defmodule BetYourBallsWeb.Api.BetController do
  use BetYourBallsWeb, :controller

  alias BetYourBalls.Repo
  alias BetYourBalls.Core.Bet

  def create(conn, %{"bet" => bet_params}) do
    changeset = Bet.changeset(%Bet{}, bet_params)

    case Repo.insert(changeset) do
      {:ok, bet} ->
        render(conn, "show.json", bet: bet)
      {:error, changeset}
        render(conn, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    Repo.get(Bet, id) 
    |> Repo.delete!()

    render(conn, "delete.json", id: id)
  end
end
