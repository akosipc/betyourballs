defmodule BetYourBallsWeb.Api.BetView do
  use BetYourBallsWeb, :view

  alias BetYourBallsWeb.Api.ApiView

  def render("show.json", %{bet: bet}) do
    %{
      bet: render_one(bet, BetYourBallsWeb.Api.BetView, "bet.json")
    }
  end

  def render("bet.json", %{bet: bet}) do
    %{ 
      id: bet.id,
      amount: bet.amount,
      currency: bet.currency
    }
  end

  def render("error.json", %{changeset: changeset}) do
    ApiView.render("error.json", %{changeset: changeset})
  end

  def render("delete.json", %{id: id}) do
    %{ id: id }
  end
end
