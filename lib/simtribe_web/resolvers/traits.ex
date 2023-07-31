defmodule SimTribeWeb.Resolvers.Traits do
  def list_traits(_parent, args, _resolution) do
    {:ok, SimTribe.Traits.list_traits(Enum.into(args, []))}
  end
end
