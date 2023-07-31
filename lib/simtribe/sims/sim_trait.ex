defmodule SimTribe.Sims.SimTrait do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sim_traits" do
    belongs_to :sim, SimTribe.Sims.Sim
    belongs_to :trait, SimTribe.Traits.Trait

    timestamps()
  end

  @doc false
  def changeset(trait, attrs) do
    trait
    |> cast(attrs, [:trait_id, :sim_id])
    |> validate_required([:trait_id, :sim_id])
  end
end
