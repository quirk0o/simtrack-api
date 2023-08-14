defmodule SimTribe.LegaciesTest do
  use SimTribe.DataCase

  alias SimTribe.Legacies

  describe "legacies" do
    alias SimTribe.Legacies.Legacy

    import SimTribe.LegaciesFixtures

    @invalid_attrs %{name: nil}

    test "list_legacies/0 returns all legacies" do
      legacy = legacy_fixture()
      assert Legacies.list_legacies() == [legacy]
    end

    test "get_legacy!/1 returns the legacy with given id" do
      legacy = legacy_fixture()
      assert Legacies.get_legacy!(legacy.id) == legacy
    end

    test "create_legacy/1 with valid data creates a legacy" do
      valid_attrs = %{name: "some name"}

      assert {:ok, %Legacy{} = legacy} = Legacies.create_legacy(valid_attrs)
      assert legacy.name == "some name"
    end

    test "create_legacy/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Legacies.create_legacy(@invalid_attrs)
    end

    test "update_legacy/2 with valid data updates the legacy" do
      legacy = legacy_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Legacy{} = legacy} = Legacies.update_legacy(legacy, update_attrs)
      assert legacy.name == "some updated name"
    end

    test "update_legacy/2 with invalid data returns error changeset" do
      legacy = legacy_fixture()
      assert {:error, %Ecto.Changeset{}} = Legacies.update_legacy(legacy, @invalid_attrs)
      assert legacy == Legacies.get_legacy!(legacy.id)
    end

    test "delete_legacy/1 deletes the legacy" do
      legacy = legacy_fixture()
      assert {:ok, %Legacy{}} = Legacies.delete_legacy(legacy)
      assert_raise Ecto.NoResultsError, fn -> Legacies.get_legacy!(legacy.id) end
    end

    test "change_legacy/1 returns a legacy changeset" do
      legacy = legacy_fixture()
      assert %Ecto.Changeset{} = Legacies.change_legacy(legacy)
    end
  end
end
