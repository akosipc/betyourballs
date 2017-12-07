defmodule BetYourBallsWeb.MatchController do
  use BetYourBallsWeb, :controller

  alias BetYourBalls.Repo
  alias BetYourBalls.Core.Match
  alias BetYourBalls.Core.User
  alias BetYourBalls.Core.Bet

  plug BetYourBalls.Plugs.EnsureAdmin when action not in [:index, :show]
  plug :scrub_params, "match" when action in [:create, :update]

  def index(conn = %Plug.Conn{assigns: %{current_user: %User{admin: true}}}, _) do
    matches = Repo.all(from m in Match, order_by: m.inserted_at)

    render(conn, "index.html", matches: matches, is_admin: true)
  end

  def index(conn, _) do
    matches = Repo.all(from m in Match, where: m.status != "pending", order_by: m.inserted_at)

    render(conn, "index.html", matches: matches, is_admin: false)
  end

  def new(conn, _) do
    changeset = Match.changeset(%Match{}, %{})

    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    match = Repo.get(Match, id)
    changeset = Match.changeset(match, %{})

    render(conn, "edit.html", match: match, changeset: changeset)
  end

  def show(conn, %{"id" => id}) do
    match = Repo.get(Match, id)

    render(conn, "show.html", 
      match: match, 
      competitor_1_amount: bet_amount_aggregator(match, :competitor_1),
      competitor_2_amount: bet_amount_aggregator(match, :competitor_2))
  end

  def create(conn, %{"match" => match_params}) do
    changeset = Match.changeset(%Match{}, match_params)

    case Repo.insert(changeset) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Successfully created a Match")
        |> redirect(to: match_path(conn, :show, match))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There are some errors encountered")
        |> render("new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "match" => match_params}) do
    match = Repo.get(Match, id)
    changeset = Match.changeset(match, match_params)

    case Repo.update(changeset) do
      {:ok, match} ->
        conn
        |> put_flash(:info, "Successfully updated a Match")
        |> redirect(to: match_path(conn, :show, match))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "There are some errors encountered")
        |> render("edit.html", changeset: changeset, match: match)
    end
  end

  # Private Queries

  defp bet_amount_aggregator(%Match{ id: match_id, competitor_1: %{ id: competitor_id } }, :competitor_1) do
    (from b in Bet, where: b.match_id == ^match_id and b.competitor_id == ^competitor_id)
    |> Repo.aggregate(:sum, :amount)
  end

  defp bet_amount_aggregator(%Match{ id: match_id, competitor_2: %{ id: competitor_id } }, :competitor_2) do
    (from b in Bet, where: b.match_id == ^match_id and b.competitor_id == ^competitor_id)
    |> Repo.aggregate(:sum, :amount)
  end
end
