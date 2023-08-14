defmodule SimTribe.Legacies.Member do
  use SimTribe.Schema
  import Ecto.Changeset

  schema "legacy_members" do

    field :legacy, :id
    field :member, :id

    timestamps()
  end

  @doc false
  def changeset(member, attrs) do
    member
    |> cast(attrs, [])
    |> validate_required([])
  end
end
