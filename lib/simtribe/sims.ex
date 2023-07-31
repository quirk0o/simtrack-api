defmodule SimTribe.Sims do
  @moduledoc """
  The Sims context.
  """

  import Ecto.Query, warn: false
  alias SimTribe.Repo

  alias SimTribe.Sims.{Sim, SimTrait}
  alias SimTribe.Traits.Trait

  def loader() do
    Dataloader.Ecto.new(Repo, query: fn queryable, _ -> queryable end)
  end

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

  def find_sim_by_name(first_name, last_name) do
    query =
      from s in Sim,
        where: s.first_name == ^first_name and s.last_name == ^last_name,
        select: s

    Repo.one(query)
  end

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

  def create_child_sim(parent1, parent2, attrs \\ %{}) do
    child_attrs = Map.merge(%{last_name: parent1.last_name}, attrs)

    %Sim{}
    |> Sim.changeset(child_attrs)
    |> Sim.parent_changeset(parent1, parent2)
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

  def update_sim_spouse(%Sim{} = sim, spouse) do
    sim
    |> Repo.preload(:spouse)
    |> Sim.spouse_changeset(spouse)
    |> Repo.update()
  end

  def update_spouses(%Sim{} = sim1, %Sim{} = sim2) do
    with {:ok, sim1} <- update_sim_spouse(sim1, sim2),
         {:ok, sim2} <- update_sim_spouse(sim2, sim1) do
      {:ok, sim1, sim2}
    else
      {:error, changeset} ->
        {:error, changeset}
    end
  end

  def add_sim_trait(%Sim{} = sim, %Trait{} = trait) do
    %SimTrait{}
    |> SimTrait.changeset(%{trait_id: trait.id, sim_id: sim.id})
    |> Repo.insert()
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
