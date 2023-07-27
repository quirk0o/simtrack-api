defmodule SimTribe.Legacies do
  @moduledoc """
  The Legacies context.
  """

  import Ecto.Query, warn: false
  alias SimTribe.Repo

  alias SimTribe.Legacies.Sim

  @doc """
  Returns the list of sims.

  ## Examples

      iex> list_sims()
      [%Sim{}, ...]

  """
  def list_sims do
    Repo.all(Sim)
  end

  @doc """
  Gets a single sim.

  Raises `Ecto.NoResultsError` if the Sim does not exist.

  ## Examples

      iex> get_sim!(123)
      %Sim{}

      iex> get_sim!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sim!(id), do: Repo.get!(Sim, id)

  @doc """
  Creates a sim.

  ## Examples

      iex> create_sim(%{field: value})
      {:ok, %Sim{}}

      iex> create_sim(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sim(attrs \\ %{}) do
    %Sim{}
    |> Sim.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sim.

  ## Examples

      iex> update_sim(sim, %{field: new_value})
      {:ok, %Sim{}}

      iex> update_sim(sim, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sim(%Sim{} = sim, attrs) do
    sim
    |> Sim.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sim.

  ## Examples

      iex> delete_sim(sim)
      {:ok, %Sim{}}

      iex> delete_sim(sim)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sim(%Sim{} = sim) do
    Repo.delete(sim)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sim changes.

  ## Examples

      iex> change_sim(sim)
      %Ecto.Changeset{data: %Sim{}}

  """
  def change_sim(%Sim{} = sim, attrs \\ %{}) do
    Sim.changeset(sim, attrs)
  end
end
