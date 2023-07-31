defmodule SimTribe.TraitsTest do
  use SimTribe.DataCase

  alias SimTribe.Traits

  describe "traits" do
    alias SimTribe.Traits.Trait

    import SimTribe.TraitsFixtures

    @invalid_attrs %{name: nil, type: nil, description: nil, img_url: nil, life_stages: nil}

    test "list_traits/0 returns all traits" do
      trait = trait_fixture()
      assert Traits.list_traits() == [trait]
    end

    test "get_trait!/1 returns the trait with given id" do
      trait = trait_fixture()
      assert Traits.get_trait!(trait.id) == trait
    end

    test "create_trait/1 with valid data creates a trait" do
      valid_attrs = %{name: "some name", type: "some type", description: "some description", img_url: "some img_url", life_stages: ["option1", "option2"]}

      assert {:ok, %Trait{} = trait} = Traits.create_trait(valid_attrs)
      assert trait.name == "some name"
      assert trait.type == "some type"
      assert trait.description == "some description"
      assert trait.img_url == "some img_url"
      assert trait.life_stages == ["option1", "option2"]
    end

    test "create_trait/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Traits.create_trait(@invalid_attrs)
    end

    test "update_trait/2 with valid data updates the trait" do
      trait = trait_fixture()
      update_attrs = %{name: "some updated name", type: "some updated type", description: "some updated description", img_url: "some updated img_url", life_stages: ["option1"]}

      assert {:ok, %Trait{} = trait} = Traits.update_trait(trait, update_attrs)
      assert trait.name == "some updated name"
      assert trait.type == "some updated type"
      assert trait.description == "some updated description"
      assert trait.img_url == "some updated img_url"
      assert trait.life_stages == ["option1"]
    end

    test "update_trait/2 with invalid data returns error changeset" do
      trait = trait_fixture()
      assert {:error, %Ecto.Changeset{}} = Traits.update_trait(trait, @invalid_attrs)
      assert trait == Traits.get_trait!(trait.id)
    end

    test "delete_trait/1 deletes the trait" do
      trait = trait_fixture()
      assert {:ok, %Trait{}} = Traits.delete_trait(trait)
      assert_raise Ecto.NoResultsError, fn -> Traits.get_trait!(trait.id) end
    end

    test "change_trait/1 returns a trait changeset" do
      trait = trait_fixture()
      assert %Ecto.Changeset{} = Traits.change_trait(trait)
    end
  end
end
