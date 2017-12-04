defmodule BetYourBallsWeb.Api.ApiView do
  use BetYourBallsWeb, :view

  def render("error.json", %{changeset: %{errors: errors}}) do
    error_messages =
      errors
      |> Enum.into(%{}, fn {key, {value, _}} -> {key, value} end)

    %{ errors: render_many(error_messages, BetYourBalls.Api.ApiView, "error_message.json") }
  end

  def render("error_message.json", error) do
    key = Map.keys(error) |> List.first
    value = Map.get(error, key)

    %{
      message: "#{key} #{value}"
    }
  end
end
