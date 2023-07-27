defmodule SimtribeWeb.SchemaTest do
  use SimTribeWeb.ConnCase

  alias SimTribe.Legacies
  import SimTribe.LegaciesFixtures

  @query """
  query getSims {
    sims {
      firstName
      lastName
      gender
      spouse {
        firstName
        lastName
      }
    }
  }
  """

  test "query: sims", %{conn: conn} do
    sim1 = sim_fixture(%{first_name: "Eliza", last_name: "Pancakes", gender: :female})
    sim2 = sim_fixture(%{first_name: "Bob", last_name: "Pancakes", gender: :male})
    {:ok, _, _} = Legacies.update_spouses(sim1, sim2)

    conn =
      post(conn, "/api/graphql", %{
        "query" => @query,
        "variables" => %{}
      })

    assert json_response(conn, 200) == %{
             "data" => %{
               "sims" => [
                 %{
                   "firstName" => "Eliza",
                   "lastName" => "Pancakes",
                   "gender" => "FEMALE",
                   "spouse" => %{
                     "firstName" => "Bob",
                     "lastName" => "Pancakes"
                   }
                 },
                 %{
                   "firstName" => "Bob",
                   "lastName" => "Pancakes",
                   "gender" => "MALE",
                   "spouse" => %{
                     "firstName" => "Eliza",
                     "lastName" => "Pancakes"
                   }
                 }
               ]
             }
           }
  end
end
