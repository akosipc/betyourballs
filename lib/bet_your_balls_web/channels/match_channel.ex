defmodule BetYourBallsWeb.MatchChannel do
  use BetYourBallsWeb, :channel

  def join("match:" <> match_id, _params, socket) do
    {:ok, socket}
  end

  def join("match:lobby", _message, _socket) do
    {:error, %{reason: "unauthorized"}}
  end
  
  def handle_in("update_price", params, socket) do
    broadcast! socket, "update_price", params
    {:noreply, socket}
  end
end
