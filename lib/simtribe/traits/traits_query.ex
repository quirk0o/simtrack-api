defmodule SimTribe.Traits.TraitsQuery do
  use SimTribe.Filterable

  import Ecto.Query, warn: false
  alias SimTribe.Traits.Trait

  def default_query(), do: query() |> active()

  def query(), do: from t in Trait

  def active(query) do
    from t in query,
      where: t.archived == false
  end

  @impl SimTribe.Filterable
  def apply_filter(query, :name, name) do
    where(query, ^string_filter(:name, name))
  end

  def apply_filter(query, :type, type) do
    where(query, type: ^type)
  end

  def apply_filter(query, :life_stage, stage) do
    where(query, [t], ^stage in t.life_stages)
  end

  def apply_filter(query, :source, source) do
    where(query, external_source: ^source)
  end

  def apply_filter(query, :external_id, external_id) when is_binary(external_id) do
    where(query, external_id: ^external_id)
  end
  def apply_filter(query, :external_id, external_id) when is_binary(external_id) do
    where(query, external_id: ^external_id)
  end


  def apply_filter(query, _key, _value), do: query
end
