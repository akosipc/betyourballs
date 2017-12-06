# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BetYourBalls.Repo.insert!(%BetYourBalls.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule BetYourBalls.DatabaseSeeder do
  alias BetYourBalls.Repo
  alias BetYourBalls.Core.User
  alias BetYourBalls.Core.Match

  def run do
    create_admin
    create_users(3)
    create_matches
  end

  defp create_admin do
    user_changeset = User.changeset(%User{}, %{
      email: "admin@byb.com",
      username: "admin",
      password: "password",
      password_confirmation: "password",
      admin: true
    })

    Repo.insert!(user_changeset)
  end

  defp create_users(n) do
    n
      |> users
      |> insert_records
  end

  defp create_matches do
    build_match_changesets
      |> insert_records
  end

  defp insert_records(list) do
    Enum.each list, fn item ->
      Repo.insert!(item)
    end
  end

  defp users(n) do
    Enum.map(1..n, fn(i) -> build_user_changeset(i) end)
  end

  defp build_user_changeset(n) do
    User.changeset(%User{}, %{
      email: "user#{n}@byb.com",
      username: "user#{n}",
      password: "password",
      admin: false
    })
  end

  defp build_match_changesets do
    Enum.map matches, fn match_params ->
      Match.changeset(%Match{}, match_params)
    end
  end

  defp matches do
    [
      %{
        title: "The International 2017",
        status: "finished",
        winner: "Team Liquid",
        game_name: "Dota 2",
        competitor_1: %{
          name: "Team Liquid",
          score: 3,
          image_url: "http://wiki.teamliquid.net/commons/images/thumb/0/07/Team_liquid_logo_2017.png/600px-Team_liquid_logo_2017.png"
        },
        competitor_2: %{
          name: "Newbee",
          score: 0,
          image_url: "http://wiki.teamliquid.net/commons/images/thumb/f/f9/Newbee_logo_text.png/462px-Newbee_logo_text.png"
        }
      },
      %{
        title: "Overwatch League",
        status: "pending",
        game_name: "Overwatch",
        competitor_1: %{
          name: "Dallas Fuel",
          image_url: "http://wiki.teamliquid.net/commons/images/thumb/0/01/Dallas_Fuel_logo.png/800px-Dallas_Fuel_logo.png"
        },
        competitor_2: %{
          name: "London Spitfire",
          image_url: "http://wiki.teamliquid.net/commons/images/thumb/9/99/London_Spitfire_logo.png/800px-London_Spitfire_logo.png"
        }
      },
      %{
        title: "Dreamleague 8",
        status: "ongoing",
        game_name: "Dota 2",
        competitor_1: %{
          name: "Fnatic",
          score: 1,
          image_url: "http://wiki.teamliquid.net/commons/images/thumb/d/db/Fnaticlogo.png/587px-Fnaticlogo.png"
        },
        competitor_2: %{
          name: "Natus Vincere",
          score: 1,
          image_url: "http://wiki.teamliquid.net/commons/images/thumb/d/d6/Natus_Vincere.png/668px-Natus_Vincere.png"
        }
      }
    ]
  end
end

BetYourBalls.DatabaseSeeder.run
