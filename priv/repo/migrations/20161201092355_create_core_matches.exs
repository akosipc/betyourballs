defmodule BetYourBalls.Repo.Migrations.CreateCoreMatches do
  use Ecto.Migration

  def change do
    create table(:core_matches) do
      add :competitor_1, :jsonb
      add :competitor_2, :jsonb
      add :winner, :string
      add :status, :string, default: "pending"

      timestamps()
    end
  end
end
