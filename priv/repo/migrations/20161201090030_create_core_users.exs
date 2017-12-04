defmodule BetYourBalls.Repo.Migrations.CreateCoreUsers do
  use Ecto.Migration

  def change do
    create table(:core_users) do
      add :email, :string
      add :username, :string
      add :password_hash, :string

      timestamps()
    end

    create unique_index(:core_users, [:email])
    create unique_index(:core_users, [:username])
  end
end
