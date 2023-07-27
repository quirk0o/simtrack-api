defmodule SimTribe.LegaciesTest do
  use SimTribe.DataCase

  alias SimTribe.Legacies

  describe "sims" do
    alias SimTribe.Legacies.Sim

    import SimTribe.LegaciesFixtures

    @invalid_attrs %{first_name: nil, last_name: nil, gender: nil, avatar_url: nil}

    test "list_sims/0 returns all sims" do
      sim = sim_fixture()
      assert Legacies.list_sims() == [sim]
    end

    test "get_sim!/1 returns the sim with given id" do
      sim = sim_fixture()
      assert Legacies.get_sim!(sim.id) == sim
    end

    test "create_sim/1 with valid data creates a sim" do
      valid_attrs = %{first_name: "Eliza", last_name: "Pancakes", gender: :female, avatar_url: "http://example.com/avatar.png"}

      assert {:ok, %Sim{} = sim} = Legacies.create_sim(valid_attrs)
      assert sim.first_name == "Eliza"
      assert sim.last_name == "Pancakes"
      assert sim.gender == :female
      assert sim.avatar_url == "http://example.com/avatar.png"
    end

    test "create_sim/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Legacies.create_sim(@invalid_attrs)
    end

    test "update_sim/2 with valid data updates the sim" do
      sim = sim_fixture()
      update_attrs = %{first_name: "Elizabeth", last_name: "Scott", gender: :male, avatar_url: "http://example.com/new_avatar.png"}

      assert {:ok, %Sim{} = sim} = Legacies.update_sim(sim, update_attrs)
      assert sim.first_name == "Elizabeth"
      assert sim.last_name == "Scott"
      assert sim.gender == :male
      assert sim.avatar_url == "http://example.com/new_avatar.png"
    end

    test "update_sim/2 with invalid data returns error changeset" do
      sim = sim_fixture()
      assert {:error, %Ecto.Changeset{}} = Legacies.update_sim(sim, @invalid_attrs)
      assert sim == Legacies.get_sim!(sim.id)
    end

    test "update_sim_spouse/2 updates the sim's spouse" do
      sim = sim_fixture()
      spouse = sim_fixture(%{first_name: "Bob", last_name: "Pancakes", gender: :male})
      assert {:ok, %Sim{} = sim} = Legacies.update_sim_spouse(sim, spouse)
      assert sim.spouse == spouse
    end

    test "update_spouses/2 updates both spouses" do
      sim = sim_fixture()
      spouse = sim_fixture(%{first_name: "Bob", last_name: "Pancakes", gender: :male})
      assert {:ok, %Sim{} = sim, %Sim{} = spouse} = Legacies.update_spouses(sim, spouse)
      assert sim.spouse_id == spouse.id
      assert spouse.spouse_id == sim.id
    end

    test "delete_sim/1 deletes the sim" do
      sim = sim_fixture()
      assert {:ok, %Sim{}} = Legacies.delete_sim(sim)
      assert_raise Ecto.NoResultsError, fn -> Legacies.get_sim!(sim.id) end
    end

    test "change_sim/1 returns a sim changeset" do
      sim = sim_fixture()
      assert %Ecto.Changeset{} = Legacies.change_sim(sim)
    end
  end
end
