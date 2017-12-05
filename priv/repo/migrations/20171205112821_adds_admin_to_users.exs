defmodule BetYourBalls.Repo.Migrations.AddAdminToUsers do
  use Ecto.Migration

  def change do
    alter table(:core_users) do
      add :admin, :boolean, default: false
    end
  end
end
