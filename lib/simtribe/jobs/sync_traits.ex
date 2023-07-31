defmodule SimTribe.Jobs.SyncTraits do
  use GenServer

  require Logger

  require IEx
  alias Airtable.Client, as: Airtable
  alias SimApi.Client, as: SimApi
  alias SimTribe.Traits

  @source "airtable"
  @period :timer.hours(24)

  def init(_) do
    Process.send_after(self(), :poll, @period)

    {:ok, %{}}
  end

  def handle_info(:poll, state) do
    Logger.info("[#{__MODULE__}] Starting job: syncing traits from Airtable")
    run()
    Logger.info("[#{__MODULE__}] Job finished: syncing traits from Airtable")

    Process.send_after(self(), :poll, @period)
    {:noreply, state}
  end

  def run() do
    with {:ok, airtable_traits} <- fetch_traits(),
         {updated_traits_num, updated_traits} <- update_traits(airtable_traits),
         {_, conflicts} <- update_conflicts(updated_traits, airtable_traits),
         {archived_traits_num, archived_traits} <- archive_legacy_traits(airtable_traits) do
      if updated_traits_num < length(airtable_traits) do
        Logger.warning(
          "[#{__MODULE__}]: Failed to update #{length(airtable_traits) - updated_traits_num} traits"
        )
      end

      if archived_traits_num > 0 do
        Logger.info(
          "[#{__MODULE__}]: Traits archived #{Enum.map(archived_traits, & &1.external_id) |> Enum.join(", ")}"
        )
      end

      {:ok, updated_traits, conflicts}
    end
  end

  def fetch_traits() do
    client = SimApi.new()

    with {:ok, traits} <- SimApi.traits(client) do
      {:ok, parse_traits(traits)}
    end
  end

  def update_traits(attrs) do
    attrs
    |> Enum.map(&build_trait/1)
    |> Traits.upsert_all_traits()
  end

  def update_conflicts(traits, attrs) do
    attrs_map = Enum.into(attrs, %{}, &{&1[:external_id], &1})

    traits
    |> Enum.flat_map(&build_conflicts(&1, attrs_map[&1.external_id]))
    |> Traits.insert_all_trait_conflicts()
  end

  def build_trait(attrs), do: Map.drop(attrs, [:conflicts])

  def build_conflicts(trait, %{conflicts: conflicts}) when is_list(conflicts) do
    Enum.map(conflicts, &%{trait_id: trait.id, conflict_id: find_trait(&1).id})
  end

  def build_conflicts(_trait, _attrs), do: []

  def archive_legacy_traits(active_traits) do
    ids = Enum.map(active_traits, & &1.external_id)
    Traits.archive_traits_by_source(@source, ids)
  end

  defp parse_traits(traits), do: Enum.map(traits, &parse_trait/1)

  defp parse_trait(trait) do
    %{
      name: Map.get(trait, :name),
      type: safe(Map.get(trait, :type), &Airtable.name_to_atom/1),
      description: Map.get(trait, :description),
      img_url: Map.get(trait, :img_url),
      life_stages: Enum.map(Map.get(trait, :life_stage), &Airtable.name_to_atom/1),
      conflicts: Map.get(trait, :conflicts),
      external_id: Map.get(trait, :id),
      external_source: @source
    }
    |> Map.filter(fn {_, v} -> !is_nil(v) end)
  end

  defp find_trait(external_id) do
    Traits.get_trait_by_external_id(@source, external_id)
  end

  defp safe(value, fun), do: if(!is_nil(value), do: fun.(value), else: nil)
end
