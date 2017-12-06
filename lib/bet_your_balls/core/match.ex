defmodule BetYourBalls.Core.Match do
  use Ecto.Schema
  import Ecto.Changeset

  alias BetYourBalls.Core.Match
  alias BetYourBalls.Core.Match.Competitor

  defmodule Competitor do
    use Ecto.Schema

    embedded_schema do
      field :name, :string
      field :score, :integer
      field :image_url, :string
    end

    @valid_attrs ~w(name score image_url)a
    @required_attrs ~w(name image_url)a

    def changeset(%Competitor{} = competitor, params \\ %{}) do
      competitor
      |> cast(params, @valid_attrs)
      |> validate_required(@required_attrs)
    end
  end

  @derive {Poison.Encoder, only: [:title, :game_name, :competitor_1, :competitor_2]}
  schema "core_matches" do
    field :winner, :string
    field :status, :string
    field :title, :string
    field :game_name, :string
    embeds_one :competitor_1, BetYourBalls.Core.Match.Competitor
    embeds_one :competitor_2, BetYourBalls.Core.Match.Competitor

    timestamps()
  end

  def status, do: ~w(pending ongoing finished)

  @valid_attrs ~w(title game_name status winner)a
  @required_attrs ~w(title game_name)a

  @doc false
  def changeset(%Match{} = match, attrs) do
    match
    |> cast(attrs, @valid_attrs)
    |> validate_required(@required_attrs)
    |> validate_inclusion(:status, Match.status)
    |> cast_embed(:competitor_1, with: &BetYourBalls.Core.Match.Competitor.changeset/2)
    |> cast_embed(:competitor_2, with: &BetYourBalls.Core.Match.Competitor.changeset/2)
  end
end
