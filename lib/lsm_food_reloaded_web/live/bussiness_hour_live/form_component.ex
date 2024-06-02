defmodule LsmFoodReloadedWeb.BussinessHourLive.FormComponent do
  use LsmFoodReloadedWeb, :live_component

  alias LsmFoodReloaded.BusinessHours

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage bussiness_hour records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="bussiness_hour-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input
          field={@form[:day]}
          type="select"
          label="Day"
          prompt="Choose a value"
          options={Ecto.Enum.values(LsmFoodReloaded.BusinessHours.BussinessHour, :day)}
        />
        <.input field={@form[:open_time]} type="time" label="Open time" step="300" />
        <.input field={@form[:close_time]} type="time" label="Close time" />
        <.input field={@form[:takeaway]} type="checkbox" label="Takeaway" />
        <.input field={@form[:dine_in]} type="checkbox" label="Dine in" />
        <.input field={@form[:delivery]} type="checkbox" label="Delivery" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Bussiness hour</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{bussiness_hour: bussiness_hour} = assigns, socket) do
    changeset = BusinessHours.change_bussiness_hour(bussiness_hour)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"bussiness_hour" => bussiness_hour_params}, socket) do
    changeset =
      socket.assigns.bussiness_hour
      |> BusinessHours.change_bussiness_hour(bussiness_hour_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"bussiness_hour" => bussiness_hour_params}, socket) do
    save_bussiness_hour(socket, socket.assigns.action, bussiness_hour_params)
  end

  defp save_bussiness_hour(socket, :edit, bussiness_hour_params) do
    case BusinessHours.update_bussiness_hour(socket.assigns.bussiness_hour, bussiness_hour_params) do
      {:ok, bussiness_hour} ->
        notify_parent({:saved, bussiness_hour})

        {:noreply,
         socket
         |> put_flash(:info, "Bussiness hour updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_bussiness_hour(socket, :new, bussiness_hour_params) do
    case BusinessHours.create_bussiness_hour(bussiness_hour_params) do
      {:ok, bussiness_hour} ->
        notify_parent({:saved, bussiness_hour})

        {:noreply,
         socket
         |> put_flash(:info, "Bussiness hour created successfully")
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
