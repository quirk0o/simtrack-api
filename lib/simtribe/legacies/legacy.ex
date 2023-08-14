defmodule SimTribe.Legacies.Legacy do
  use SimTribe.Schema
  import Ecto.Changeset

  alias SimTribe.Sims.Sim

  schema "legacies" do
    field :name, :string

    belongs_to :founder, Sim

    many_to_many :sims, Sim,
      join_through: "legacy_members",
      join_keys: [legacy_id: :id, member_id: :id],
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(legacy, attrs) do
    legacy
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> validate_length(:name, min: 1, max: 255)
    |> unique_constraint(:name)
  end
end
