defmodule LsmFoodReloadedWeb.BussinessHourLive.Show do
  use LsmFoodReloadedWeb, :live_view

  alias LsmFoodReloaded.BusinessHours

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:bussiness_hour, BusinessHours.get_bussiness_hour!(id))}
  end

  defp page_title(:show), do: "Show Bussiness hour"
  defp page_title(:edit), do: "Edit Bussiness hour"
end
