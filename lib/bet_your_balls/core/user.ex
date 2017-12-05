defmodule BetYourBalls.Core.User do
  use Ecto.Schema
  use Coherence.Schema
  import Ecto.Changeset
  alias BetYourBalls.Core.User

  schema "core_users" do
    field :email, :string
    field :username, :string
    field :admin, :boolean

    has_many :bets, BetYourBalls.Core.Bet

    coherence_schema()

    timestamps()
  end

  @required_attrs ~w(username email)a

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, @required_attrs ++ coherence_fields())
    |> validate_required(@required_attrs)
    |> validate_format(:email, ~r/\A[^@\s]+@[^@\s]+\z/i)
    |> validate_coherence(attrs)
    |> unique_constraint(:email, on: BetYourBalls.Repo, downcase: true)
    |> unique_constraint(:username, on: BetYourBalls.Repo)
  end
end
