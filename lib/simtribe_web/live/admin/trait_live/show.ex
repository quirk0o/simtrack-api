defmodule SimTribeWeb.Admin.TraitLive.Show do
  use SimTribeWeb, type: :live_view, layout: {SimTribeWeb.Layouts, :admin}

  alias SimTribe.Traits

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:trait, Traits.get_trait!(id))}
  end

  defp page_title(:show), do: "Show Trait"
  defp page_title(:edit), do: "Edit Trait"
end
