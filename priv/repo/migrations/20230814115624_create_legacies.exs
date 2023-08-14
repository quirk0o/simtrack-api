defmodule SimTribe.Repo.Migrations.CreateLegacies do
  use Ecto.Migration

  def change do
    create table(:legacies) do
      add :name, :string, null: false
      add :founder_id, references(:sims, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:legacies, [:name])
    create index(:legacies, [:founder_id])
  end
end
