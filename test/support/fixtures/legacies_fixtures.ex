defmodule SimTribe.LegaciesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimTribe.Legacies` context.
  """

  @doc """
  Generate a sim.
  """
  def sim_fixture(attrs \\ %{}) do
    {:ok, sim} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name",
        gender: :female,
        avatar_url: "http://example.com/avatar.png"
      })
      |> SimTribe.Legacies.create_sim()

    sim
  end
end
