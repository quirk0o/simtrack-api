defmodule SimTribe.TraitsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SimTribe.Traits` context.
  """

  @doc """
  Generate a trait.
  """
  def trait_fixture(attrs \\ %{}) do
    {:ok, trait} =
      attrs
      |> Enum.into(%{
        name: "some name",
        type: "some type",
        description: "some description",
        img_url: "some img_url",
        life_stages: ["option1", "option2"]
      })
      |> SimTribe.Traits.create_trait()

    trait
  end
end
