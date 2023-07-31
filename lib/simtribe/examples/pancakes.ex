defmodule SimTribe.Examples.Pancakes do
  alias SimTribe.Sims

  def eliza_attrs() do
    %{
      first_name: "Eliza",
      last_name: "Pancakes",
      traits: ["Materialistic", "Neat", "Perfectionist"],
      gender: :female
    }
  end

  def bob_attrs() do
    %{
      first_name: "Bob",
      last_name: "Pancakes",
      traits: ["Slob", "Gloomy", "Loner"],
      gender: :male
    }
  end

  def iggy_attrs() do
    %{
      first_name: "Iggy",
      last_name: "Pancakes",
      traits: ["Charmer"],
      gender: :male
    }
  end

  def eliza() do
    {:ok, eliza} = Sims.create_sim(eliza_attrs())
    eliza
  end

  def bob() do
    {:ok, bob} = Sims.create_sim(bob_attrs())
    bob
  end

  def iggy() do
    {:ok, iggy} = Sims.create_sim(iggy_attrs())
    iggy
  end

  def family() do
    {:ok, eliza, bob} = Sims.update_spouses(eliza(), bob())
    {:ok, iggy} = Sims.create_child_sim(eliza, bob, iggy_attrs())
    %{eliza: eliza, bob: bob, iggy: iggy}
  end
end
