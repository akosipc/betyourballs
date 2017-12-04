defmodule BetYourBalls.Repo.Migrations.CreateCoreBets do
  use Ecto.Migration

  def change do
    create table(:core_bets) do
      add :amount, :float
      add :currency, :string
      add :status, :string, default: "pending"
      add :betted_on, :string

      add :user_id, references(:core_users, on_delete: :delete_all)
      add :match_id, references(:core_matches, on_delete: :delete_all)

      add :transaction, :jsonb, default: {}

      timestamps()
    end

    create index(:core_bets, [:user_id])
    create index(:core_bets, [:match_id])
  end
end
