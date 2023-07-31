defmodule SimApi.Helpers do
  alias Airtable.Client, as: Airtable

  def parse_record(record) do
    record["fields"]
    |> Map.new(fn {k, v} -> {Airtable.name_to_atom(k), v} end)
    |> Map.put(:id, record["id"])
  end

  def get_records(client, table_name) do
    with {:ok, records} <- Airtable.list_records(client, table_name) do
      {:ok, Enum.map(records, &parse_record/1)}
    end
  end
end
