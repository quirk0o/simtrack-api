defmodule SimTribe.Repo.Migrations.RenameInsertedAtToCreatedAt do
  use Ecto.Migration

  def change do
    rename(table(:users), :inserted_at, to: :created_at)
    rename(table(:users_tokens), :inserted_at, to: :created_at)
    rename(table(:sims), :inserted_at, to: :created_at)
    rename(table(:traits), :inserted_at, to: :created_at)
    rename(table(:trait_conflicts), :inserted_at, to: :created_at)
    rename(table(:sim_traits), :inserted_at, to: :created_at)
    rename(table(:legacies), :inserted_at, to: :created_at)
    rename(table(:legacy_members), :inserted_at, to: :created_at)
  end
end
