defmodule SimTribeWeb.Schema.SimsContentTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias SimTribe.Sims.Sim
  alias SimTribeWeb.Resolvers

  enum :gender do
    value :female
    value :male
  end

  object :sim do
    field :id, :id
    field :first_name, :string
    field :last_name, :string

    field :name, :string, resolve: &Resolvers.Sims.sim_name/3

    field :gender, :gender
    field :avatar_url, :string

    field :parent1, :sim, resolve: dataloader(Sim)
    field :parent2, :sim, resolve: dataloader(Sim)
    field :spouse, :sim, resolve: dataloader(Sim)
  end
end
