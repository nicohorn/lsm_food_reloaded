defmodule LsmFoodReloadedWeb.BusinessHourLive.FormComponent do
  use LsmFoodReloadedWeb, :live_component

  alias LsmFoodReloaded.BusinessHours

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage business_hour records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="business_hour-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:active]} type="checkbox" label="Active" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Business hour</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{business_hour: business_hour} = assigns, socket) do
    changeset = BusinessHours.change_business_hour(business_hour)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"business_hour" => business_hour_params}, socket) do
    changeset =
      socket.assigns.business_hour
      |> BusinessHours.change_business_hour(business_hour_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"business_hour" => business_hour_params}, socket) do
    save_business_hour(socket, socket.assigns.action, business_hour_params)
  end

  defp save_business_hour(socket, :edit, business_hour_params) do
    case BusinessHours.update_business_hour(socket.assigns.business_hour, business_hour_params) do
      {:ok, business_hour} ->
        notify_parent({:saved, business_hour})

        {:noreply,
         socket
         |> put_flash(:info, "Business hour updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_business_hour(socket, :new, business_hour_params) do
    case BusinessHours.create_business_hour(business_hour_params) do
      {:ok, business_hour} ->
        notify_parent({:saved, business_hour})

        {:noreply,
         socket
         |> put_flash(:info, "Business hour created successfully")
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
