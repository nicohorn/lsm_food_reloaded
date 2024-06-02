defmodule LsmFoodReloadedWeb.BussinessHourLive.Index do
  use LsmFoodReloadedWeb, :live_view

  alias LsmFoodReloaded.BusinessHours
  alias LsmFoodReloaded.BusinessHours.BussinessHour

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
    |> assign(:page_title, "Edit Bussiness hour")
    |> assign(:bussiness_hour, BusinessHours.get_bussiness_hour!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Bussiness hour")
    |> assign(:bussiness_hour, %BussinessHour{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Business hours")
    |> assign(:bussiness_hour, nil)
  end

  @impl true
  def handle_info({LsmFoodReloadedWeb.BussinessHourLive.FormComponent, {:saved, bussiness_hour}}, socket) do
    {:noreply, stream_insert(socket, :business_hours, bussiness_hour)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    bussiness_hour = BusinessHours.get_bussiness_hour!(id)
    {:ok, _} = BusinessHours.delete_bussiness_hour(bussiness_hour)

    {:noreply, stream_delete(socket, :business_hours, bussiness_hour)}
  end
end
