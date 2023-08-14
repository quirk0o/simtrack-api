defmodule SimTribeWeb.Schema.Notation do
  import Absinthe.Schema.Notation, only: [field: 2, field: 3, non_null: 1, list_of: 1]

  defmacro field!(identifier, attrs) when is_list(attrs) do
    quote do
      field(unquote(identifier), unquote(attrs))
    end
  end

  defmacro field!(identifier, type) do
    quote do
      field(unquote(identifier), non_null(unquote(type)))
    end
  end

  defmacro field!(identifier, type, attrs) do
    quote do
      field(unquote(identifier), non_null(unquote(type)), unquote(attrs))
    end
  end

  defmacro arg!(identifier, attrs) when is_list(attrs) do
    quote do
      arg(unquote(identifier), unquote(attrs))
    end
  end

  defmacro arg!(identifier, type) do
    quote do
      arg(unquote(identifier), non_null(unquote(type)))
    end
  end

  defmacro arg!(identifier, type, attrs) do
    quote do
      arg(unquote(identifier), non_null(unquote(type)), unquote(attrs))
    end
  end

  defmacro list_of!(type) do
    quote do
      list_of(non_null(unquote(type)))
    end
  end
end
