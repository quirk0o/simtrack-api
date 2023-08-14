defmodule SimTribe.Traits.Trait do
  use SimTribe.Schema
  import Ecto.Changeset

  alias SimTribe.Traits.Conflict

  @required_attrs ~w(name type life_stages external_id external_source)a
  @types ~w(infant toddler emotional hobby lifestyle social)a
  @life_stages ~w(infant toddler child teen young_adult adult elder)a

  schema "traits" do
    field :name, :string
    field :type, Ecto.Enum, values: @types
    field :description, :string
    field :img_url, :string
    field :life_stages, {:array, Ecto.Enum}, values: @life_stages

    field :external_id, :string
    field :external_source, :string
    field :archived, :boolean, default: false

    many_to_many :conflicts, __MODULE__,
      join_through: Conflict,
      join_keys: [trait_id: :id, conflict_id: :id],
      on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(trait, attrs) do
    trait
    |> cast(attrs, [
      :name,
      :img_url,
      :description,
      :type,
      :life_stages,
      :external_id,
      :external_source,
      :archived
    ])
    |> validate_required(@required_attrs)
    |> validate_inclusion(:type, @types)
    |> cast_assoc(:conflicts, with: &SimTribe.Traits.Conflict.changeset/2)
  end
end
