defmodule SimTribe.Traits.Randomizer do
  alias SimTribe.Sims.Sim
  alias SimTribe.Traits.Trait

  @callback random_trait(Sim.t()) :: Trait.t()

  defmacro __using__(_opts \\ []) do
    quote do
      @behaviour unquote(__MODULE__)
    end
  end
end
