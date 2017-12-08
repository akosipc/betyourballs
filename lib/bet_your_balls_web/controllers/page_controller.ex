defmodule BetYourBallsWeb.PageController do
  use BetYourBallsWeb, :controller

  def index(%{assigns: %{ current_user: nil }} = conn, _params) do
    conn
    |> redirect(to: session_path(conn, :new))
  end

  def index(conn, _params) do
    conn
    |> redirect(to: match_path(conn, :index))
  end
end
