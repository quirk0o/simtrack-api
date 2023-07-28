defmodule Airtable.Client do
  def name_to_atom(name) do
    name
    |> String.downcase()
    |> String.replace(" ", "_")
    |> String.to_atom()
  end

  def list_tables() do
    client()
    |> Tesla.get("/meta/bases/#{base_id()}/tables")
    |> case do
      {:ok, %Tesla.Env{status: 200, body: body}} -> {:ok, body["tables"]}
      response -> response
    end
  end

  def list_records(table_name) do
    client()
    |> Tesla.get("/#{base_id()}/#{table_name}")
    |> case do
      {:ok, %Tesla.Env{status: 200, body: body}} -> {:ok, body["records"]}
      response -> response
    end
  end

  defp client do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.airtable.com/v0"},
      {Tesla.Middleware.Headers,
       [{"authorization", "Bearer #{Application.fetch_env!(:simtribe, __MODULE__)[:api_key]}"}]},
      Tesla.Middleware.JSON
    ]

    Tesla.client(middleware)
  end

  defp base_id, do: Application.fetch_env!(:simtribe, __MODULE__)[:base_id]
end
