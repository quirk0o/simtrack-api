defmodule SimTribe.Traits.Randomizers.Ancestral do
  use SimTribe.Traits.Randomizer

  import Ecto.Query
  require IEx
  alias SimTribe.Repo
  alias SimTribe.Traits.TraitsQuery
  alias SimTribe.Sims.Sim
  alias SimTribe.Traits.Randomizers.WeightedRandom

  @impl SimTribe.Traits.Randomizer
  def random_trait(sim) do
    traits = weighted_traits(sim)
      WeightedRandom.random(traits)
  end

  def weighted_traits(sim) do
    ancestral = ancestral_traits(sim)
    random = possible_traits(sim)

    Enum.concat(ancestral, random)
    |> Enum.uniq_by(&elem(&1, 0).id)
  end

  defp compatible_traits_query(sim) do
    TraitsQuery.default_query() |> TraitsQuery.compatible(sim)
  end

  def ancestral_traits(%Sim{parent1: nil, parent2: nil}), do: []

  def ancestral_traits(%Sim{parent1: parent1, parent2: parent2} = sim) do
    ancestors = [parent1, parent2] |> Enum.reject(&is_nil/1)

    q =
      from t in compatible_traits_query(sim),
        where: t.id in subquery(from at in Ecto.assoc(ancestors, :traits), select: at.id),
        select: {t, type(^weight(:ancestral), :integer)}

    Repo.all(q)
  end

  def possible_traits(sim) do
    q =
      from t in compatible_traits_query(sim),
        select: {t, type(^weight(:random), :integer)}

    Repo.all(q)
  end

  defp weight(:random), do: 1
  defp weight(:ancestral), do: 2
end
