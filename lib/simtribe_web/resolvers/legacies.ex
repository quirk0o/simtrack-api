defmodule SimTribeWeb.Resolvers.Legacies do
  alias SimTribe.Legacies
  alias SimTribe.Legacies.Legacy

  def list_legacies(_parent, _args, _resolution) do
    {:ok, Legacies.list_legacies()}
  end

  def get_legacy(%{id: id}, _args, _resolution) do
    Legacies.get_legacy(id)
    |> format_payload()
  end

  def create_legacy(_parent, %{input: input}, _resolution) do
    Legacies.create_legacy(input)
  end

  def delete_legacy(_parent, %{id: id}, _resolution) do
    Legacies.delete_legacy(id)
    |> format_payload()
  end

  defp error_message(:not_found), do: "Legacy not found"
  defp error_message(e), do: to_string(e)

  defp format_payload({:error, e} = payload) when is_atom(e), do: {:error, error_message(e)}
  defp format_payload(payload), do: payload
end
