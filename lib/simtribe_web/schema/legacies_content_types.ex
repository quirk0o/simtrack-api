defmodule SimTribeWeb.Schema.LegaciesContentTypes do
  use Absinthe.Schema.Notation

  enum :gender do
    value :female
    value :male
  end

  object :sim do
    field :id, :id
    field :first_name, :string
    field :last_name, :string
    field :gender, :gender
    field :avatar_url, :string
  end
end
