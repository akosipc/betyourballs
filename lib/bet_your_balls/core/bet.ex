defmodule BetYourBalls.Core.Bet do
  use Ecto.Schema
  import Ecto.Changeset

  alias BetYourBalls.Core.Bet
  alias BetYourBalls.Core.Bet.Transaction

  defmodule Transaction do
    use Ecto.Schema

    embedded_schema do
      field :identifier, :string
      field :source, :string
      field :number, :string
      field :amount, :string
      field :date, :utc_datetime
      field :details, :map
    end
    
    @valid_attrs ~w(id source number amount date details)a

    def changeset(%Transaction{} = transaction, params \\ %{}) do
      transaction
      |> cast(params, @valid_attrs)
    end
  end

  schema "core_bets" do
    field :amount, :float
    field :currency, :string
    field :status, :string
    belongs_to :user, BetYourBalls.Core.User
    belongs_to :match, BetYourBalls.Core.Match

    embeds_one :transaction, BetYourBalls.Core.Bet.Transaction

    timestamps()
  end

  def currency, do: ~w(CHAL USD)
  def status, do: ~w(pending paid void)

  @valid_attrs ~w(amount currency status user_id match_id)a
  @required_attrs ~w(amount currency user_id match_id)a

  @doc false
  def changeset(%Bet{} = bet, attrs) do
    bet
    |> cast(attrs, @valid_attrs)
    |> validate_required(@required_attrs)
    |> validate_inclusion(:currency, Bet.currency)
    |> validate_inclusion(:status, Bet.status)
    |> cast_embed(:transaction, with: &BetYourBalls.Core.Bet.Transaction.changeset/2)
  end
end
