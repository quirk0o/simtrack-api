defmodule SimTribe.SimsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimTribe.Sims` context.
  """

  @doc """
  Generate a sim.
  """
  def sim_fixture(attrs \\ %{}) do
    {:ok, sim} =
      attrs
      |> Enum.into(%{
        first_name: "Eliza",
        last_name: "Pancakes",
        gender: :female,
        avatar_url: "http://example.com/avatar.png"
      })
      |> SimTribe.Sims.create_sim()

    sim
  end
end
