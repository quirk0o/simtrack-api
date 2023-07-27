defmodule SimTribeWeb.Schema do
  use Absinthe.Schema
  import_types SimTribeWeb.Schema.LegaciesContentTypes

  alias SimTribeWeb.Resolvers

  query do
    @desc "Get all Sims"
    field :sims, list_of(:sim) do
      resolve &Resolvers.Legacies.list_sims/3
    end
  end
end
