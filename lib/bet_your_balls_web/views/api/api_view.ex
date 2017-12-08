defmodule BetYourBallsWeb.Api.ApiView do
  use BetYourBallsWeb, :view

  def render("error.json", %{changeset: %{errors: errors}}) do
    error_messages =
      errors
      |> Enum.into(%{}, fn {key, {value, _}} -> {key, value} end)

    %{ errors: render_many(error_messages, BetYourBallsWeb.Api.ApiView, "error_message.json") }
  end

  def render("error_message.json", %{api: {key, value}}) do
    %{
      message: "#{key} #{value}"
    }
  end
end
