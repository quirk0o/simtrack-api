defmodule Airtable.Client do
  defstruct [:tesla, :base_id]

  def new(api_key, base_id) do
    Finch.start_link(name: Airtable.Finch)

    middleware = [
      {Tesla.Middleware.BaseUrl, "https://api.airtable.com/v0"},
      {Tesla.Middleware.Headers, [{"authorization", "Bearer #{api_key}"}]},
      Tesla.Middleware.JSON
    ]

    %__MODULE__{
      tesla: Tesla.client(middleware, {Tesla.Adapter.Finch, name: Airtable.Finch}),
      base_id: base_id
    }
  end

  def name_to_atom(name) do
    name
    |> String.downcase()
    |> String.replace(" ", "_")
    |> String.to_atom()
  end

  def list_tables(%__MODULE__{} = client) do
    client.tesla
    |> Tesla.get("/meta/bases/#{client.base_id}/tables")
    |> case do
      {:ok, %{status: 200, body: body}} -> {:ok, body["tables"]}
      response -> response
    end
  end

  def list_records(%__MODULE__{} = client, table_name) do
    client.tesla
    |> Tesla.get("/#{client.base_id}/#{table_name}")
    |> case do
      {:ok, %{status: 200, body: body}} -> {:ok, body["records"]}
      response -> response
    end
  end
end
