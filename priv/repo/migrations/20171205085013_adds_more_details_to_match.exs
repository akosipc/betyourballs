defmodule BetYourBalls.Repo.Migrations.AddsMoreDetailsToMatch do
  use Ecto.Migration

  def change do
    alter table(:core_matches) do
      add :title, :string
      add :game_name, :string
    end

    create index(:core_matches, [:title])
  end
end
