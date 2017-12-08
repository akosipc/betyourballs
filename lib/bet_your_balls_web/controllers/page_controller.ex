defmodule BetYourBallsWeb.PageController do
  use BetYourBallsWeb, :controller

  def index(conn, _params) do
    conn
    |> redirect(to: session_path(conn, :new))
  end
end
