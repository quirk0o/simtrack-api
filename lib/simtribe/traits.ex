defmodule SimTribe.Traits do
  @moduledoc """
  The Traits context.
  """

  import Ecto.Query, warn: false
  alias SimTribe.Repo

  alias SimTribe.Traits.{Trait, Conflict}
  import SimTribe.Traits.TraitsQuery

  def loader() do
    Dataloader.Ecto.new(Repo,
      query: fn
        Trait, _ -> default_query()
        queryable, _ -> queryable
      end
    )
  end

  @doc """
  Returns the list of traits.

  ## Examples

      iex> list_traits()
      [%Trait{}, ...]

  """
  @spec list_traits(filter: map()) :: [Trait.t()]
  def list_traits(opts \\ []) do
    q =
      default_query()
      |> filter(Keyword.get(opts, :filter, %{}))

    Repo.all(q)
  end

  @doc """
  Gets a single trait.

  Raises `Ecto.NoResultsError` if the Trait does not exist.

  ## Examples

      iex> get_trait!(123)
      %Trait{}

      iex> get_trait!(456)
      ** (Ecto.NoResultsError)

  """
  def get_trait!(id), do: Repo.get!(Trait, id)

  def get_trait_by_external_id(external_id, source),
    do: Repo.get_by(Trait, external_id: external_id, external_source: source)

  def get_trait_by_name(name), do: Repo.get_by(default_query(), name: name)

  @doc """
  Creates a trait.

  ## Examples

      iex> create_trait(%{field: value})
      {:ok, %Trait{}}

      iex> create_trait(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_trait(attrs \\ %{}) do
    %Trait{}
    |> Trait.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a trait.

  ## Examples

      iex> update_trait(trait, %{field: new_value})
      {:ok, %Trait{}}

      iex> update_trait(trait, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_trait(%Trait{} = trait, attrs) do
    trait
    |> Trait.changeset(attrs)
    |> Repo.update()
  end

  def archive_traits_by_source(source, active_ids) do
    q =
      from t in query(),
        where: t.external_source == ^source,
        where: t.external_id not in ^active_ids

    archive_all_traits(q)
  end

  defp archive_all_traits(query), do: Repo.update_all(query, set: [archived: true])

  @doc """
  Deletes a trait.

  ## Examples

      iex> delete_trait(trait)
      {:ok, %Trait{}}

      iex> delete_trait(trait)
      {:error, %Ecto.Changeset{}}

  """
  def delete_trait(%Trait{} = trait) do
    Repo.delete(trait)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking trait changes.

  ## Examples

      iex> change_trait(trait)
      %Ecto.Changeset{data: %Trait{}}

  """
  def change_trait(%Trait{} = trait, attrs \\ %{}) do
    Trait.changeset(trait, attrs)
  end

  def delete_all_traits do
    Repo.delete_all(Trait)
  end

  def upsert_all_traits(trait_attrs) do
    insert_all_traits(trait_attrs,
      on_conflict: {:replace, [:name, :type, :description, :img_url, :life_stages, :updated_at]},
      conflict_target: [:external_id, :external_source]
    )
  end

  def create_trait_conflict(%Trait{} = trait, %Trait{} = conflicting_trait) do
    %Conflict{}
    |> Conflict.changeset(%{trait_id: trait.id, conflict_id: conflicting_trait.id})
    |> Repo.insert()
  end

  defp insert_all_traits(trait_attrs, opts \\ []) do
    placeholders = %{timestamp: timestamp()}

    traits =
      trait_attrs
      |> Stream.map(&Map.put(&1, :inserted_at, {:placeholder, :timestamp}))
      |> Enum.map(&Map.put(&1, :updated_at, {:placeholder, :timestamp}))

    Repo.insert_all(
      Trait,
      traits,
      Keyword.merge(opts, placeholders: placeholders, returning: true)
    )
  end

  defp timestamp() do
    NaiveDateTime.utc_now()
    |> NaiveDateTime.truncate(:second)
  end
end
