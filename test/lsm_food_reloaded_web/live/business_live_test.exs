defmodule LsmFoodReloadedWeb.BusinessLiveTest do
  use LsmFoodReloadedWeb.ConnCase

  import Phoenix.LiveViewTest
  import LsmFoodReloaded.BusinessesFixtures

  @create_attrs %{enabled: true, name: "some name", address: "some address", description: "some description", image: "some image", phone_number: 42, socials: ["option1", "option2"], featured: :premium}
  @update_attrs %{enabled: false, name: "some updated name", address: "some updated address", description: "some updated description", image: "some updated image", phone_number: 43, socials: ["option1"], featured: :sponsored}
  @invalid_attrs %{enabled: false, name: nil, address: nil, description: nil, image: nil, phone_number: nil, socials: [], featured: nil}

  defp create_business(_) do
    business = business_fixture()
    %{business: business}
  end

  describe "Index" do
    setup [:create_business]

    test "lists all businesses", %{conn: conn, business: business} do
      {:ok, _index_live, html} = live(conn, ~p"/businesses")

      assert html =~ "Listing Businesses"
      assert html =~ business.name
    end

    test "saves new business", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/businesses")

      assert index_live |> element("a", "New Business") |> render_click() =~
               "New Business"

      assert_patch(index_live, ~p"/businesses/new")

      assert index_live
             |> form("#business-form", business: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#business-form", business: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/businesses")

      html = render(index_live)
      assert html =~ "Business created successfully"
      assert html =~ "some name"
    end

    test "updates business in listing", %{conn: conn, business: business} do
      {:ok, index_live, _html} = live(conn, ~p"/businesses")

      assert index_live |> element("#businesses-#{business.id} a", "Edit") |> render_click() =~
               "Edit Business"

      assert_patch(index_live, ~p"/businesses/#{business}/edit")

      assert index_live
             |> form("#business-form", business: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#business-form", business: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/businesses")

      html = render(index_live)
      assert html =~ "Business updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes business in listing", %{conn: conn, business: business} do
      {:ok, index_live, _html} = live(conn, ~p"/businesses")

      assert index_live |> element("#businesses-#{business.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#businesses-#{business.id}")
    end
  end

  describe "Show" do
    setup [:create_business]

    test "displays business", %{conn: conn, business: business} do
      {:ok, _show_live, html} = live(conn, ~p"/businesses/#{business}")

      assert html =~ "Show Business"
      assert html =~ business.name
    end

    test "updates business within modal", %{conn: conn, business: business} do
      {:ok, show_live, _html} = live(conn, ~p"/businesses/#{business}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Business"

      assert_patch(show_live, ~p"/businesses/#{business}/show/edit")

      assert show_live
             |> form("#business-form", business: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#business-form", business: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/businesses/#{business}")

      html = render(show_live)
      assert html =~ "Business updated successfully"
      assert html =~ "some updated name"
    end
  end
end
