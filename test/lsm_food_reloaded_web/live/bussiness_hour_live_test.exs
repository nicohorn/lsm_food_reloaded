defmodule LsmFoodReloadedWeb.BussinessHourLiveTest do
  use LsmFoodReloadedWeb.ConnCase

  import Phoenix.LiveViewTest
  import LsmFoodReloaded.BusinessHoursFixtures

  @create_attrs %{day: :domingo, open_time: "14:00", close_time: "14:00", takeaway: true, dine_in: true, delivery: true}
  @update_attrs %{day: :lunes, open_time: "15:01", close_time: "15:01", takeaway: false, dine_in: false, delivery: false}
  @invalid_attrs %{day: nil, open_time: nil, close_time: nil, takeaway: false, dine_in: false, delivery: false}

  defp create_bussiness_hour(_) do
    bussiness_hour = bussiness_hour_fixture()
    %{bussiness_hour: bussiness_hour}
  end

  describe "Index" do
    setup [:create_bussiness_hour]

    test "lists all business_hours", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/business_hours")

      assert html =~ "Listing Business hours"
    end

    test "saves new bussiness_hour", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/business_hours")

      assert index_live |> element("a", "New Bussiness hour") |> render_click() =~
               "New Bussiness hour"

      assert_patch(index_live, ~p"/business_hours/new")

      assert index_live
             |> form("#bussiness_hour-form", bussiness_hour: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bussiness_hour-form", bussiness_hour: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/business_hours")

      html = render(index_live)
      assert html =~ "Bussiness hour created successfully"
    end

    test "updates bussiness_hour in listing", %{conn: conn, bussiness_hour: bussiness_hour} do
      {:ok, index_live, _html} = live(conn, ~p"/business_hours")

      assert index_live |> element("#business_hours-#{bussiness_hour.id} a", "Edit") |> render_click() =~
               "Edit Bussiness hour"

      assert_patch(index_live, ~p"/business_hours/#{bussiness_hour}/edit")

      assert index_live
             |> form("#bussiness_hour-form", bussiness_hour: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#bussiness_hour-form", bussiness_hour: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/business_hours")

      html = render(index_live)
      assert html =~ "Bussiness hour updated successfully"
    end

    test "deletes bussiness_hour in listing", %{conn: conn, bussiness_hour: bussiness_hour} do
      {:ok, index_live, _html} = live(conn, ~p"/business_hours")

      assert index_live |> element("#business_hours-#{bussiness_hour.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#business_hours-#{bussiness_hour.id}")
    end
  end

  describe "Show" do
    setup [:create_bussiness_hour]

    test "displays bussiness_hour", %{conn: conn, bussiness_hour: bussiness_hour} do
      {:ok, _show_live, html} = live(conn, ~p"/business_hours/#{bussiness_hour}")

      assert html =~ "Show Bussiness hour"
    end

    test "updates bussiness_hour within modal", %{conn: conn, bussiness_hour: bussiness_hour} do
      {:ok, show_live, _html} = live(conn, ~p"/business_hours/#{bussiness_hour}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Bussiness hour"

      assert_patch(show_live, ~p"/business_hours/#{bussiness_hour}/show/edit")

      assert show_live
             |> form("#bussiness_hour-form", bussiness_hour: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#bussiness_hour-form", bussiness_hour: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/business_hours/#{bussiness_hour}")

      html = render(show_live)
      assert html =~ "Bussiness hour updated successfully"
    end
  end
end
