defmodule SimTribe.Repo.Migrations.CreateTraits do
  use Ecto.Migration

  def change do
    create table(:traits) do
      add :name, :string, null: false
      add :type, :string, null: false
      add :img_url, :string
      add :description, :string, size: 1000
      add :life_stages, {:array, :string}, null: false

      add :external_id, :string
      add :external_source, :string
      add :archived, :boolean, null: false, default: false

      timestamps()
    end

    create unique_index(:traits, [:external_id, :external_source])
  end
end
