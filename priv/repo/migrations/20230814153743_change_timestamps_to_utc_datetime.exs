defmodule SimTribe.Repo.Migrations.ChangeTimestampsToUtcDatetime do
  use Ecto.Migration

  def change do
    alter table(:users) do
      modify :created_at, :utc_datetime, from: :naive_datetime
      modify :updated_at, :utc_datetime, from: :naive_datetime
    end

    alter table(:users_tokens) do
      modify :created_at, :utc_datetime, from: :naive_datetime
    end

    alter table(:sims) do
      modify :created_at, :utc_datetime, from: :naive_datetime
      modify :updated_at, :utc_datetime, from: :naive_datetime
    end

    alter table(:traits) do
      modify :created_at, :utc_datetime, from: :naive_datetime
      modify :updated_at, :utc_datetime, from: :naive_datetime
    end

    alter table(:trait_conflicts) do
      modify :created_at, :utc_datetime, from: :naive_datetime
      modify :updated_at, :utc_datetime, from: :naive_datetime
    end

    alter table(:sim_traits) do
      modify :created_at, :utc_datetime, from: :naive_datetime
      modify :updated_at, :utc_datetime, from: :naive_datetime
    end

    alter table(:legacies) do
      modify :created_at, :utc_datetime, from: :naive_datetime
      modify :updated_at, :utc_datetime, from: :naive_datetime
    end

    alter table(:legacy_members) do
      modify :created_at, :utc_datetime, from: :naive_datetime
      modify :updated_at, :utc_datetime, from: :naive_datetime
    end
  end
end
