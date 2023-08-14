defmodule SimTribeWeb.Schema.LegaciesContentTypes do
  use Absinthe.Schema.Notation
  import AbsintheErrorPayload.Payload
  import SimTribeWeb.Schema.Notation
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  alias SimTribe.Sims.Sim

  object :legacy do
    field! :id, :id
    field! :name, :string
    field! :created_at, :datetime
    field! :updated_at, :datetime

    field :founder, :sim, resolve: dataloader(Sim)
    field! :sims, list_of!(:sim), resolve: dataloader(Sim)
  end

  input_object :create_legacy_input do
    field! :name, :string
    field :founder_id, :id
  end

  payload_object(:create_legacy_payload, :legacy)
  payload_object(:delete_legacy_payload, :legacy)
end
