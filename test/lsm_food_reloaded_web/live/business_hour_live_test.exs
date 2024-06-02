defmodule LsmFoodReloadedWeb.BusinessHourLiveTest do
  use LsmFoodReloadedWeb.ConnCase

  import Phoenix.LiveViewTest
  import LsmFoodReloaded.BusinessHoursFixtures

  @create_attrs %{active: true, name: "some name"}
  @update_attrs %{active: false, name: "some updated name"}
  @invalid_attrs %{active: false, name: nil}

  defp create_business_hour(_) do
    business_hour = business_hour_fixture()
    %{business_hour: business_hour}
  end

  describe "Index" do
    setup [:create_business_hour]

    test "lists all business_hours", %{conn: conn, business_hour: business_hour} do
      {:ok, _index_live, html} = live(conn, ~p"/business_hours")

      assert html =~ "Listing Business hours"
      assert html =~ business_hour.name
    end

    test "saves new business_hour", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/business_hours")

      assert index_live |> element("a", "New Business hour") |> render_click() =~
               "New Business hour"

      assert_patch(index_live, ~p"/business_hours/new")

      assert index_live
             |> form("#business_hour-form", business_hour: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#business_hour-form", business_hour: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/business_hours")

      html = render(index_live)
      assert html =~ "Business hour created successfully"
      assert html =~ "some name"
    end

    test "updates business_hour in listing", %{conn: conn, business_hour: business_hour} do
      {:ok, index_live, _html} = live(conn, ~p"/business_hours")

      assert index_live |> element("#business_hours-#{business_hour.id} a", "Edit") |> render_click() =~
               "Edit Business hour"

      assert_patch(index_live, ~p"/business_hours/#{business_hour}/edit")

      assert index_live
             |> form("#business_hour-form", business_hour: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#business_hour-form", business_hour: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/business_hours")

      html = render(index_live)
      assert html =~ "Business hour updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes business_hour in listing", %{conn: conn, business_hour: business_hour} do
      {:ok, index_live, _html} = live(conn, ~p"/business_hours")

      assert index_live |> element("#business_hours-#{business_hour.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#business_hours-#{business_hour.id}")
    end
  end

  describe "Show" do
    setup [:create_business_hour]

    test "displays business_hour", %{conn: conn, business_hour: business_hour} do
      {:ok, _show_live, html} = live(conn, ~p"/business_hours/#{business_hour}")

      assert html =~ "Show Business hour"
      assert html =~ business_hour.name
    end

    test "updates business_hour within modal", %{conn: conn, business_hour: business_hour} do
      {:ok, show_live, _html} = live(conn, ~p"/business_hours/#{business_hour}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Business hour"

      assert_patch(show_live, ~p"/business_hours/#{business_hour}/show/edit")

      assert show_live
             |> form("#business_hour-form", business_hour: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#business_hour-form", business_hour: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/business_hours/#{business_hour}")

      html = render(show_live)
      assert html =~ "Business hour updated successfully"
      assert html =~ "some updated name"
    end
  end
end
