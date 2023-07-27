defmodule SimTribeWeb.Schema do
  use Absinthe.Schema
  import_types SimTribeWeb.Schema.SimsContentTypes

  alias SimTribe.Sims
  alias SimTribe.Sims.Sim
  alias SimTribeWeb.Resolvers

  query do
    @desc "Get all Sims"
    field :sims, list_of(:sim) do
      resolve &Resolvers.Sims.list_sims/3
    end
  end

  def context(ctx) do
    loader =
      Dataloader.new()
      |> Dataloader.add_source(Sim, Sims.sims_data())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
