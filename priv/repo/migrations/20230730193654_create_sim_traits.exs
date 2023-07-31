defmodule SimTribe.Repo.Migrations.CreateSimTraits do
  use Ecto.Migration

  def change do
    create table(:sim_traits) do
      add :sim_id, references(:sims, on_delete: :delete_all)
      add :trait_id, references(:traits, on_delete: :delete_all)

      timestamps()
    end

    create index(:sim_traits, [:sim_id])
    create index(:sim_traits, [:trait_id])
  end
end
