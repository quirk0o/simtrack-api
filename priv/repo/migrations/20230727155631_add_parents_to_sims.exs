defmodule SimTribe.Repo.Migrations.AddParentsToSims do
  use Ecto.Migration

  def change do
    alter table(:sims) do
      add :parent1_id, references(:sims, on_delete: :nilify_all)
      add :parent2_id, references(:sims, on_delete: :nilify_all)
    end
  end
end
