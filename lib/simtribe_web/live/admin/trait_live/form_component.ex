defmodule SimTribeWeb.Admin.TraitLive.FormComponent do
  use SimTribeWeb, :live_component

  alias SimTribe.Traits

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage trait records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="trait-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:type]} type="text" label="Type" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:img_url]} type="text" label="Img url" />
        <.input
          field={@form[:life_stages]}
          type="select"
          multiple
          label="Life stages"
          options={[{"Option 1", "option1"}, {"Option 2", "option2"}]}
        />
        <.input field={@form[:external_id]} type="text" label="External" />
        <.input field={@form[:external_source]} type="text" label="External source" />
        <.input field={@form[:archived]} type="checkbox" label="Archived" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Trait</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{trait: trait} = assigns, socket) do
    changeset = Traits.change_trait(trait)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"trait" => trait_params}, socket) do
    changeset =
      socket.assigns.trait
      |> Traits.change_trait(trait_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"trait" => trait_params}, socket) do
    save_trait(socket, socket.assigns.action, trait_params)
  end

  defp save_trait(socket, :edit, trait_params) do
    case Traits.update_trait(socket.assigns.trait, trait_params) do
      {:ok, trait} ->
        notify_parent({:saved, trait})

        {:noreply,
         socket
         |> put_flash(:info, "Trait updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_trait(socket, :new, trait_params) do
    case Traits.create_trait(trait_params) do
      {:ok, trait} ->
        notify_parent({:saved, trait})

        {:noreply,
         socket
         |> put_flash(:info, "Trait created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
