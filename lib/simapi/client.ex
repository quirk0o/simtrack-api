defmodule SimApi.Client do
  alias Airtable.Client, as: Airtable
  import SimApi.Helpers

  def new() do
    api_key = Application.fetch_env!(:simtribe, Airtable)[:api_key]
    base_id = Application.fetch_env!(:simtribe, Airtable)[:base_id]

    Airtable.new(api_key, base_id)
  end

  def traits(client) do
    get_records(client, "Traits")
  end

  def aspirations(client) do
    get_records(client, "Aspirations")
  end

  def careers(client) do
    get_records(client, "Careers")
  end

  def skills(client) do
    get_records(client, "Skills")
  end
end
