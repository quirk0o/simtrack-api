defmodule SimTribeWeb.Schema.TraitsContentTypes do
  use Absinthe.Schema.Notation

  enum :trait_type do
    value :infant
    value :toddler
    value :emotional
    value :hobby
    value :lifestyle
    value :social
  end

  enum :trait_life_stage do
    value :infant
    value :toddler
    value :child
    value :teen
    value :adult
  end

  object :trait do
    field :id, :id
    field :name, :string
    field :type, :trait_type
    field :description, :string
    field :img_url, :string
    field :life_stages, list_of(:trait_life_stage)
  end

  input_object :trait_filter do
    field :type, :trait_type
    field :life_stage, :trait_life_stage
  end
end
