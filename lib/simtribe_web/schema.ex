defmodule SimTribeWeb.Schema do
  use Absinthe.Schema

  import AbsintheErrorPayload.Payload
  import SimTribeWeb.Schema.Notation
  import_types Absinthe.Type.Custom
  import_types AbsintheErrorPayload.ValidationMessageTypes
  import_types SimTribeWeb.Schema.LegaciesContentTypes
  import_types SimTribeWeb.Schema.SimsContentTypes
  import_types SimTribeWeb.Schema.TraitsContentTypes

  alias SimTribe.Legacies
  alias SimTribe.Legacies.Legacy
  alias SimTribe.Sims
  alias SimTribe.Sims.Sim
  alias SimTribe.Traits
  alias SimTribe.Traits.Trait
  alias SimTribeWeb.Resolvers

  query do
    @desc "Get all Sims"
    field :sims, non_null(list_of!(:sim)) do
      resolve &Resolvers.Sims.list_sims/3
    end

    @desc "Get all traits"
    field :traits, non_null(list_of!(:trait)) do
      arg :filter, :trait_filter
      resolve &Resolvers.Traits.list_traits/3
    end

    @desc "Get all legacies"
    field :legacies, non_null(list_of!(:legacy)) do
      resolve &Resolvers.Legacies.list_legacies/3
    end
  end

  mutation do
    @desc "Create a legacy"
    field :create_legacy, non_null(:create_legacy_payload) do
      arg! :input, :create_legacy_input
      resolve &Resolvers.Legacies.create_legacy/3
      middleware &build_payload/2
    end

    @desc "Delete a legacy"
    field :delete_legacy, non_null(:delete_legacy_payload) do
      arg! :id, :id
      resolve &Resolvers.Legacies.delete_legacy/3
      middleware &build_payload/2
    end
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Legacy, Legacies.loader())
      |> Dataloader.add_source(Sim, Sims.loader())
      |> Dataloader.add_source(Trait, Traits.loader())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
