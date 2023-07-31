defmodule SimTribe.Filterable do
  @callback apply_filter(Ecto.Queryable.t(), atom(), term()) :: Ecto.Query.t()
  import Ecto.Query

  defmacro __using__(_opts \\ []) do
    quote do
      @behaviour unquote(__MODULE__)
      import unquote(__MODULE__)

      @spec filter(Ecto.Queryable.t(), Keyword.t()) :: Ecto.Query.t()
      def filter(queryable, params) do
        Enum.reduce(params, queryable, fn {key, value}, query ->
          apply_filter(query, key, value)
        end)
      end
    end
  end

  def string_filter(key, value) when is_binary(value) do
    dynamic([q], field(q, ^key) == ^value)
  end

  def string_filter(key, %{in: values}) when is_list(values) do
    dynamic([q], field(q, ^key) in ^values)
  end
end
