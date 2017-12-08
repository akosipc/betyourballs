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
  alias BetYourBalls.Core.Bet

  def run do
    delete_all_records
    create_admin
    create_users(3)
    create_matches
  end

  defp delete_all_records do
    structs = [User, Match, Bet]

    Enum.each structs, fn struct ->
      Repo.delete_all(struct)
    end
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
          image_url: "http://wiki.teamliquid.net/commons/images/thumb/1/1e/Liquidlogobig.png/300px-Liquidlogobig.png"
        },
        competitor_2: %{
          name: "Newbee",
          score: 0,
          image_url: "https://d1u5p3l4wpay3k.cloudfront.net/dota2_gamepedia/thumb/1/17/Team_logo_NewBee.png/256px-Team_logo_NewBee.png?version=8f8db0a2598949f004e6f33c5aa611c0"
        }
      },
      %{
        title: "Overwatch League",
        status: "pending",
        game_name: "Overwatch",
        competitor_1: %{
          name: "Dallas Fuel",
          image_url: "https://bnetcmsus-a.akamaihd.net/cms/template_resource/YX6JZ6FR89LU1507822882865.svg"
        },
        competitor_2: %{
          name: "London Spitfire",
          image_url: "https://pbs.twimg.com/profile_images/926832820667813890/uiaYjGFA.jpg"
        }
      },
      %{
        title: "Dreamleague 8",
        status: "ongoing",
        game_name: "Dota 2",
        competitor_1: %{
          name: "Fnatic",
          score: 1,
          image_url: "https://crunchbase-production-res.cloudinary.com/image/upload/c_lpad,h_256,w_256,f_jpg/v1491582179/zh57ucoscq75zlfyguvs.png"
        },
        competitor_2: %{
          name: "Natus Vincere",
          score: 1,
          image_url: "https://lol.gamepedia.com/media/lol.gamepedia.com/thumb/b/bf/NaVi_logo.png/300px-NaVi_logo.png?version=f2541815f8d21d902a9254d32e199621"
        }
      }
    ]
  end
end

BetYourBalls.DatabaseSeeder.run
