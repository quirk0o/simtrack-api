defmodule SimTribeWeb.Schema do
  use Absinthe.Schema
  import_types SimTribeWeb.Schema.SimsContentTypes
  import_types SimTribeWeb.Schema.TraitsContentTypes

  alias SimTribe.Sims
  alias SimTribe.Sims.Sim
  alias SimTribe.Traits
  alias SimTribe.Traits.Trait
  alias SimTribeWeb.Resolvers

  query do
    @desc "Get all Sims"
    field :sims, list_of(:sim) do
      resolve &Resolvers.Sims.list_sims/3
    end

    @desc "Get all traits"
    field :traits, list_of(:trait) do
      arg :filter, :trait_filter
      resolve &Resolvers.Traits.list_traits/3
    end
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Sim, Sims.loader())
      |> Dataloader.add_source(Trait, Traits.loader())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
