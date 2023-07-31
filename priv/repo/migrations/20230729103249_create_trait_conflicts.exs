defmodule SimTribe.Repo.Migrations.CreateTraitConflicts do
  use Ecto.Migration

  def change do
    create table(:trait_conflicts) do
      add :trait_id, references(:traits, on_delete: :nothing)
      add :conflict_id, references(:traits, on_delete: :nothing)

      timestamps()
    end

    create index(:trait_conflicts, [:trait_id])
    create unique_index(:trait_conflicts, [:trait_id, :conflict_id])
  end
end
