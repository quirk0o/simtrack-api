defmodule SimTribe.Sims.Sim do
  use Ecto.Schema
  import Ecto.Changeset

  alias SimTribe.Sims.SimTrait
  alias SimTribe.Traits
  alias SimTribe.Traits.Trait

  @required_attrs ~w(first_name last_name gender)a
  @genders ~w(female male)a
  @ages ~w(infant toddler child teen young_adult adult elder)a

  schema "sims" do
    field :first_name, :string
    field :last_name, :string
    field :gender, Ecto.Enum, values: @genders
    field :age, Ecto.Enum, values: @ages, default: :young_adult
    field :avatar_url, :string

    many_to_many :traits, Trait, join_through: SimTrait, on_replace: :delete

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
      :age,
      :avatar_url,
      :spouse_id,
      :parent1_id,
      :parent2_id
    ])
    |> validate_required(@required_attrs)
    |> validate_inclusion(:gender, @genders)
    |> validate_inclusion(:age, @ages)
    |> put_traits(attrs[:traits])
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

  defp put_traits(changeset, nil), do: changeset

  defp put_traits(changeset, trait_names) do
    traits = Traits.list_traits(filter: %{name: %{in: trait_names}})
    put_assoc(changeset, :traits, traits)
  end
end
