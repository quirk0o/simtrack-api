defmodule SimTribe.Repo.Migrations.AddSpousesToSims do
  use Ecto.Migration

  def change do
    alter table(:sims) do
      add :spouse_id, references(:sims, on_delete: :nilify_all)
    end
  end
end
