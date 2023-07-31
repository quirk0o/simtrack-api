defmodule SimTribe.Jobs.SyncTraits do
  use GenServer

  require Logger

  alias Airtable.Client, as: Airtable
  alias SimApi.Client, as: SimApi
  alias SimTribe.Traits

  @period :timer.hours(24)

  def init(_) do
    Process.send_after(self(), :poll, @period)

    {:ok, :state}
  end

  def handle_info(:poll, _state) do
    Logger.info("[#{__MODULE__}] Starting job: syncing traits from Airtable")
    run()
    Logger.info("[#{__MODULE__}] Job finished: syncing traits from Airtable")

    Process.send_after(self(), :poll, @period)
  end

  def run() do
    with {:ok, active_traits} <- fetch_traits(),
         {successes, updated_traits} <- update_traits(active_traits),
         {_, archived_traits} <- archive_legacy_traits(updated_traits) do
      if successes < length(active_traits) do
        Logger.warning(
          "[#{__MODULE__}]: Failed to update #{length(active_traits) - successes} traits"
        )
      end

      if archived_traits do
        Logger.info(
          "[#{__MODULE__}]: Traits archived #{Enum.map(archived_traits, & &1.external_id) |> Enum.join(", ")}"
        )
      end

      {:ok, updated_traits}
    end
  end

  def fetch_traits() do
    client = SimApi.new()

    with {:ok, traits} <- SimApi.traits(client) do
      {:ok, parse_traits(traits)}
    end
  end

  def update_traits(traits) do
    traits
    |> Traits.upsert_all_traits()
  end

  def archive_legacy_traits(active_traits) do
    ids = Enum.map(active_traits, & &1.external_id)
    Traits.archive_traits_by_source("airtable", ids)
  end

  defp parse_traits(traits), do: Enum.map(traits, &parse_trait/1)

  defp parse_trait(trait) do
    %{
      name: Map.get(trait, :name),
      type: safe(Map.get(trait, :type), &Airtable.name_to_atom/1),
      description: Map.get(trait, :description),
      img_url: Map.get(trait, :img_url),
      life_stages: Enum.map(Map.get(trait, :life_stage), &Airtable.name_to_atom/1),
      external_id: Map.get(trait, :id),
      external_source: "airtable"
    }
    |> Map.filter(fn {_, v} -> !is_nil(v) end)
  end

  def safe(value, fun), do: if(!is_nil(value), do: fun.(value), else: nil)
end
