defmodule SimTribe.Legacies.Sim do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Enum

  @required_attrs ~w(first_name last_name gender)a
  @genders ~w(female male)a

  schema "sims" do
    field :first_name, :string
    field :last_name, :string
    field :gender, Enum, values: @genders
    field :avatar_url, :string

    belongs_to :spouse, __MODULE__, on_replace: :nilify
    belongs_to :parent1, __MODULE__, on_replace: :nilify
    belongs_to :parent2, __MODULE__, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(sim, attrs) do
    sim
    |> cast(attrs, [
      :first_name,
      :last_name,
      :gender,
      :avatar_url,
      :spouse_id,
      :parent1_id,
      :parent2_id
    ])
    |> validate_required(@required_attrs)
    |> validate_inclusion(:gender, @genders)
  end

  def spouse_changeset(sim, spouse \\ nil) do
    sim
    |> change()
    |> put_assoc(:spouse, spouse)
  end

  def parent_changeset(sim, parent1 \\ nil, parent2 \\ nil) do
    sim
    |> change()
    |> put_assoc(:parent1, parent1)
    |> put_assoc(:parent2, parent2)
  end
end
