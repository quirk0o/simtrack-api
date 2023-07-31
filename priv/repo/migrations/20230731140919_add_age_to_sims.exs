defmodule SimTribe.Repo.Migrations.AddAgeToSims do
  use Ecto.Migration

  def change do
    alter table(:sims) do
      add :age, :string
    end
  end
end
