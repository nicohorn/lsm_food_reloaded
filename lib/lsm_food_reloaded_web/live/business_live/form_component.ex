defmodule LsmFoodReloadedWeb.BusinessLive.FormComponent do
  use LsmFoodReloadedWeb, :live_component

  alias LsmFoodReloaded.Businesses

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage business records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="business-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:description]} type="text" label="Description" />
        <.input field={@form[:phone_number]} type="text" label="Phone number" />
        <.input field={@form[:address]} type="text" label="Address" />
        <.input field={@form[:socials]} type="text" label="Socials" />
        <.input
          field={@form[:featured]}
          type="select"
          label="Featured"
          prompt="Choose a value"
          options={Ecto.Enum.values(LsmFoodReloaded.Businesses.Business, :featured)}
        />
        <.input field={@form[:enabled]} type="checkbox" label="Enabled" />
        <.input field={@form[:image]} type="text" label="Image" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Business</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{business: business} = assigns, socket) do
    changeset = Businesses.change_business(business)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"business" => business_params}, socket) do
    changeset =
      socket.assigns.business
      |> Businesses.change_business(business_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"business" => business_params}, socket) do
    save_business(socket, socket.assigns.action, business_params)
  end

  defp save_business(socket, :edit, business_params) do
    case Businesses.update_business(socket.assigns.business, business_params) do
      {:ok, business} ->
        notify_parent({:saved, business})

        {:noreply,
         socket
         |> put_flash(:info, "Business updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_business(socket, :new, business_params) do
    case Businesses.create_business(business_params) do
      {:ok, business} ->
        notify_parent({:saved, business})

        {:noreply,
         socket
         |> put_flash(:info, "Business created successfully")
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
