defmodule SimTribe.Repo.Migrations.CreateLegacyMembers do
  use Ecto.Migration

  def change do
    create table(:legacy_members) do
      add :legacy_id, references(:legacies, on_delete: :delete_all)
      add :member_id, references(:sims, on_delete: :delete_all)

      timestamps()
    end

    create index(:legacy_members, [:legacy_id])
    create index(:legacy_members, [:member_id])
  end
end
