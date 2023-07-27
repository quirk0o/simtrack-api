defmodule SimTribeWeb.Resolvers.Sims do
  def sim_name(parent, _args, _resolution) do
    {:ok, parent.first_name <> " " <> parent.last_name}
  end

  def list_sims(_parent, _args, _resolution) do
    {:ok, SimTribe.Sims.list_sims()}
  end
end
