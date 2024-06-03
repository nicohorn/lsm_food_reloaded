defmodule LsmFoodReloadedWeb.BusinessHourLive.Index do
  use LsmFoodReloadedWeb, :live_view

  alias LsmFoodReloaded.BusinessHours
  alias LsmFoodReloaded.BusinessHours.BusinessHour

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :business_hours, BusinessHours.list_business_hours())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Business hour")
    |> assign(:business_hour, BusinessHours.get_business_hour!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Business hour")
    |> assign(:business_hour, %BusinessHour{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Business hours")
    |> assign(:business_hour, nil)
  end

  @impl true
  def handle_info(
        {LsmFoodReloadedWeb.BusinessHourLive.FormComponent, {:saved, business_hour}},
        socket
      ) do
    {:noreply, stream_insert(socket, :business_hours, business_hour)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    business_hour = BusinessHours.get_business_hour!(id)
    {:ok, _} = BusinessHours.delete_business_hour(business_hour)

    {:noreply, stream_delete(socket, :business_hours, business_hour)}
  end
end
