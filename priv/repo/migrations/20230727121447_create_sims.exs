defmodule SimTribe.Repo.Migrations.CreateSims do
  use Ecto.Migration

  def change do
    create table(:sims) do
      add :first_name, :string
      add :last_name, :string
      add :gender, :string
      add :avatar_url, :string

      timestamps()
    end
  end
end
