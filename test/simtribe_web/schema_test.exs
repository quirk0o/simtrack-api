defmodule SimTribeWeb.SchemaTest do
  use SimTribeWeb.ConnCase

  alias SimTribe.Sims
  import SimTribe.SimsFixtures

  @query """
  query getSims {
    sims {
      firstName
      lastName
      gender
      parent1 {
        name
      }
      parent2 {
        name
      }
      spouse {
        name
      }
    }
  }
  """

  test "query: sims", %{conn: conn} do
    parent1 = sim_fixture(%{first_name: "Eliza", last_name: "Pancakes", gender: :female})
    parent2 = sim_fixture(%{first_name: "Bob", last_name: "Pancakes", gender: :male})
    {:ok, _, _} = Sims.update_spouses(parent1, parent2)
    {:ok, _} = Sims.create_child_sim(parent1, parent2, %{first_name: "Iggy", gender: :male})

    conn =
      post(conn, "/api/graphql", %{
        "query" => @query,
        "variables" => %{}
      })

    body = json_response(conn, 200)
    sims = body["data"]["sims"]
    assert length(sims) == 3

    assert Enum.find(sims, fn sim -> sim["firstName"] == "Eliza" end) == %{
             "firstName" => "Eliza",
             "lastName" => "Pancakes",
             "gender" => "FEMALE",
             "parent1" => nil,
             "parent2" => nil,
             "spouse" => %{
               "name" => "Bob Pancakes"
             }
           }

    assert Enum.find(sims, fn sim -> sim["firstName"] == "Bob" end) == %{
             "firstName" => "Bob",
             "lastName" => "Pancakes",
             "gender" => "MALE",
             "parent1" => nil,
             "parent2" => nil,
             "spouse" => %{
               "name" => "Eliza Pancakes"
             }
           }

    assert Enum.find(sims, fn sim -> sim["firstName"] == "Iggy" end) == %{
             "firstName" => "Iggy",
             "lastName" => "Pancakes",
             "gender" => "MALE",
             "parent1" => %{
               "name" => "Eliza Pancakes"
             },
             "parent2" => %{
               "name" => "Bob Pancakes"
             },
             "spouse" => nil
           }
  end
end
