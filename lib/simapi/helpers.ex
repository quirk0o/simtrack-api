defmodule SimApi.Helpers do
  alias Airtable.Client, as: Airtable

  defmacro __using__(_options) do
    quote do
      alias Airtable.Client, as: Airtable
      import unquote(__MODULE__)

    end
  end

  def fetch_tables! do
    case Airtable.list_tables() do
      {:ok, tables} -> tables
      {:error, error} -> raise "Error fetching tables from Airtable: #{inspect(error)}"
    end
  end

  def parse_record(record) do
    record["fields"]
    |> Map.new(fn {k, v} -> {Airtable.name_to_atom(k), v} end)
  end

  def get_records(table_name) do
    with {:ok, records} <- Airtable.list_records(table_name) do
      {:ok, Enum.map(records, &parse_record/1)}
    end
  end
end
