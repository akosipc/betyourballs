defmodule BetYourBalls.Repo.Migrations.AddsBetToCompetitor do
  use Ecto.Migration

  def change do
    alter table(:core_bets) do
      add :competitor_id, :string
    end

    create index(:core_bets, [:competitor_id])
  end
end
