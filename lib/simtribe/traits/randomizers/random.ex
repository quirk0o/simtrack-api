defmodule SimTribe.Traits.Randomizers.Random do
  use SimTribe.Traits.Randomizer

  alias SimTribe.Traits

  @impl SimTribe.Traits.Randomizer
  def random_trait(sim) do
    possible_traits(sim)
    |> Enum.random()
  end

  defp possible_traits(sim) do
    Traits.list_compatible_traits(sim)
  end
end
