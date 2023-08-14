defmodule SimTribe.Schema do
  defmacro __using__(_) do
    quote do
      use Ecto.Schema

      @timestamps_opts [
        type: :utc_datetime,
        inserted_at: :created_at,
        inserted_at_source: :created_at
      ]
    end
  end
end
