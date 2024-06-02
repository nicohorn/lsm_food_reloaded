defmodule LsmFoodReloadedWeb.BusinessHourLive.Show do
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
     |> assign(:business_hour, BusinessHours.get_business_hour!(id))}
  end

  defp page_title(:show), do: "Show Business hour"
  defp page_title(:edit), do: "Edit Business hour"
end
