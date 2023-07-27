defmodule SimTribeWeb.Resolvers.Legacies do
  def list_sims(_parent, _args, _resolution) do
    {:ok, SimTribe.Legacies.list_sims()}
  end
end
