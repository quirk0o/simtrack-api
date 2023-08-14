defmodule SimTribeWeb.Admin.TraitLive.Index do
  use SimTribeWeb, type: :live_view, layout: {SimTribeWeb.Layouts, :admin}

  alias SimTribe.Traits
  alias SimTribe.Traits.Trait

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :traits, Traits.list_traits())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Trait")
    |> assign(:trait, Traits.get_trait!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Trait")
    |> assign(:trait, %Trait{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Traits")
    |> assign(:trait, nil)
  end

  @impl true
  def handle_info({SimTribeWeb.Admin.TraitLive.FormComponent, {:saved, trait}}, socket) do
    {:noreply, stream_insert(socket, :traits, trait)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    trait = Traits.get_trait!(id)
    {:ok, _} = Traits.delete_trait(trait)

    {:noreply, stream_delete(socket, :traits, trait)}
  end
end
