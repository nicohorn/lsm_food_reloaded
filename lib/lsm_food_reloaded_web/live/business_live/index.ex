defmodule LsmFoodReloadedWeb.BusinessLive.Index do
  use LsmFoodReloadedWeb, :live_view

  alias LsmFoodReloaded.Businesses
  alias LsmFoodReloaded.Businesses.Business

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :businesses, Businesses.list_businesses())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Business")
    |> assign(:business, Businesses.get_business!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Business")
    |> assign(:business, %Business{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Businesses")
    |> assign(:business, nil)
  end

  @impl true
  def handle_info({LsmFoodReloadedWeb.BusinessLive.FormComponent, {:saved, business}}, socket) do
    {:noreply, stream_insert(socket, :businesses, business)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    business = Businesses.get_business!(id)
    {:ok, _} = Businesses.delete_business(business)

    {:noreply, stream_delete(socket, :businesses, business)}
  end
end
