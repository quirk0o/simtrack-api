defmodule SimTribe.Legacies do
  @moduledoc """
  The Legacies context.
  """

  import Ecto.Query, warn: false
  alias SimTribe.Repo

  alias SimTribe.Legacies.Legacy

  def loader() do
    Dataloader.Ecto.new(Repo, query: fn queryable, _ -> queryable end)
  end

  @doc """
  Returns the list of legacies.

  ## Examples

      iex> list_legacies()
      [%Legacy{}, ...]

  """
  def list_legacies do
    Repo.all(Legacy)
  end

  @doc """
  Gets a single legacy.

  Raises `Ecto.NoResultsError` if the Legacy does not exist.

  ## Examples

      iex> get_legacy!(123)
      %Legacy{}

      iex> get_legacy!(456)
      ** (Ecto.NoResultsError)

  """
  def get_legacy!(id), do: Repo.get!(Legacy, id)
  def get_legacy(id) do
    case Repo.get(Legacy, id) do
      nil -> {:error, :not_found}
      legacy -> {:ok, legacy}
    end
  end

  @doc """
  Creates a legacy.

  ## Examples

      iex> create_legacy(%{field: value})
      {:ok, %Legacy{}}

      iex> create_legacy(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_legacy(attrs \\ %{}) do
    %Legacy{}
    |> Legacy.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a legacy.

  ## Examples

      iex> update_legacy(legacy, %{field: new_value})
      {:ok, %Legacy{}}

      iex> update_legacy(legacy, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_legacy(%Legacy{} = legacy, attrs) do
    legacy
    |> Legacy.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a legacy.

  ## Examples

      iex> delete_legacy(legacy)
      {:ok, %Legacy{}}

      iex> delete_legacy(legacy)
      {:error, %Ecto.Changeset{}}

  """
  def delete_legacy(%Legacy{} = legacy) do
    Repo.delete(legacy)
  end

  def delete_legacy(id) do
    case get_legacy(id) do
      {:ok, legacy} -> delete_legacy(legacy)
      error -> error
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking legacy changes.

  ## Examples

      iex> change_legacy(legacy)
      %Ecto.Changeset{data: %Legacy{}}

  """
  def change_legacy(%Legacy{} = legacy, attrs \\ %{}) do
    Legacy.changeset(legacy, attrs)
  end
end
