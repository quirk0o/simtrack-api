defmodule SimTribe.Traits.Randomizers.WeightedRandom do
  def random(items) do
    value =
      items
      |> sum_weights()
      |> :rand.uniform()

    select_item(items, value)
  end

  def select_item([{trait, weight} | _tail], value) when weight >= value, do: trait
  def select_item([{_, weight} | tail], value), do: select_item(tail, value - weight)

  def sum_weights(items) do
    Enum.reduce(items, 0, fn {_, weight}, acc -> acc + weight end)
  end

end
