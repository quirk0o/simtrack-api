defmodule SimTribe.Traits.Conflict do
  use SimTribe.Schema
  import Ecto.Changeset

  schema "trait_conflicts" do
    belongs_to :trait, SimTribe.Traits.Trait
    belongs_to :conflict, SimTribe.Traits.Trait

    timestamps()
  end

  @doc false
  def changeset(conflict, attrs) do
    conflict
    |> cast(attrs, [])
    |> validate_required([])
  end
end
