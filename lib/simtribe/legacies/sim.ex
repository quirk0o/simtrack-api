defmodule SimTribe.Legacies.Sim do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Enum

  schema "sims" do
    field :first_name, :string
    field :last_name, :string
    field :gender, Enum, values: [:female, :male]
    field :avatar_url, :string

    belongs_to :spouse, SimTribe.Legacies.Sim, on_replace: :nilify

    timestamps()
  end

  @doc false
  def changeset(sim, attrs) do
    sim
    |> cast(attrs, [:first_name, :last_name, :gender, :avatar_url, :spouse_id])
    |> validate_required([:first_name, :last_name, :gender])
    |> validate_inclusion(:gender, [:female, :male])
  end

  def spouse_changeset(sim, spouse \\ nil) do
    sim
    |> change()
    |> put_assoc(:spouse, spouse)
  end
end
