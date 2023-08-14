defmodule SimTribe.LegaciesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimTribe.Legacies` context.
  """

  @doc """
  Generate a legacy.
  """
  def legacy_fixture(attrs \\ %{}) do
    {:ok, legacy} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> SimTribe.Legacies.create_legacy()

    legacy
  end
end
