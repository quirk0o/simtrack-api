defmodule SimApi.Client do
  alias Airtable.Client, as: Airtable
  import SimApi.Helpers

  @tables fetch_tables!()

  @tables
  |> Enum.each(fn table ->
    name = Airtable.name_to_atom(table["name"])

    def unquote(name)() do
      get_records(unquote(table["name"]))
    end
  end)
end
