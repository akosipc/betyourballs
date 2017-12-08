defmodule BetYourBallsWeb.Api.BetController do
  use BetYourBallsWeb, :controller

  alias BetYourBalls.Repo
  alias BetYourBalls.Core.Bet

  def create(conn, %{"bet" => bet_params}) do
    changeset = Bet.changeset(%Bet{}, bet_params)

    case Repo.insert(changeset) do
      {:ok, %{match_id: match_id} = bet} ->
        BetYourBallsWeb.Endpoint.broadcast("match:#{match_id}", "update_price", %{
          id: bet.id,
          competitor_id: bet.competitor_id,
          amount: bet.amount
        })

        conn
        |> put_status(201)
        |> render("show.json", bet: bet)
      {:error, changeset} ->
        conn
        |> put_status(422)
        |> render("error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    Repo.get(Bet, id) 
    |> Repo.delete!()

    render(conn, "delete.json", id: id)
  end
end
