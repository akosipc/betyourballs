defmodule BetYourBalls.Core.Match do
  use Ecto.Schema
  import Ecto.Changeset

  alias BetYourBalls.Core.Match
  alias BetYourBalls.Core.Match.Competitor

  defmodule Competitor do
    use Ecto.Schema

    embedded_schema do
      field :name, {:array, :string}, default: []
      field :score, :integer
    end

    @valid_attrs ~w(name score)a

    def changeset(%Competitor{} = competitor, params \\ %{}) do
      competitor
      |> cast(params, @valid_attrs)
      |> validate_required(@valid_attrs)
    end
  end

  schema "core_matches" do
    field :winner, :string
    field :status, :string
    embeds_one :competitor_1, BetYourBalls.Core.Match.Competitor
    embeds_one :competitor_2, BetYourBalls.Core.Match.Competitor

    timestamps()
  end

  def status, do: ~w(pending ongoing finished)

  @required_attrs ~w(status winner)a

  @doc false
  def changeset(%Match{} = match, attrs) do
    match
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
    |> validate_inclusion(:status, Match.status)
    |> cast_embed(:competitor_1, with: &BetYourBalls.Core.Match.Competitor.changeset/2)
    |> cast_embed(:competitor_2, with: &BetYourBalls.Core.Match.Competitor.changeset/2)
  end
end
