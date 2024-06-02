defmodule LsmFoodReloaded.BusinessHoursTest do
  use LsmFoodReloaded.DataCase

  alias LsmFoodReloaded.BusinessHours

  describe "business_hours" do
    alias LsmFoodReloaded.BusinessHours.BussinessHour

    import LsmFoodReloaded.BusinessHoursFixtures

    @invalid_attrs %{day: nil, open_time: nil, close_time: nil, takeaway: nil, dine_in: nil, delivery: nil}

    test "list_business_hours/0 returns all business_hours" do
      bussiness_hour = bussiness_hour_fixture()
      assert BusinessHours.list_business_hours() == [bussiness_hour]
    end

    test "get_bussiness_hour!/1 returns the bussiness_hour with given id" do
      bussiness_hour = bussiness_hour_fixture()
      assert BusinessHours.get_bussiness_hour!(bussiness_hour.id) == bussiness_hour
    end

    test "create_bussiness_hour/1 with valid data creates a bussiness_hour" do
      valid_attrs = %{day: :domingo, open_time: ~T[14:00:00], close_time: ~T[14:00:00], takeaway: true, dine_in: true, delivery: true}

      assert {:ok, %BussinessHour{} = bussiness_hour} = BusinessHours.create_bussiness_hour(valid_attrs)
      assert bussiness_hour.day == :domingo
      assert bussiness_hour.open_time == ~T[14:00:00]
      assert bussiness_hour.close_time == ~T[14:00:00]
      assert bussiness_hour.takeaway == true
      assert bussiness_hour.dine_in == true
      assert bussiness_hour.delivery == true
    end

    test "create_bussiness_hour/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = BusinessHours.create_bussiness_hour(@invalid_attrs)
    end

    test "update_bussiness_hour/2 with valid data updates the bussiness_hour" do
      bussiness_hour = bussiness_hour_fixture()
      update_attrs = %{day: :lunes, open_time: ~T[15:01:01], close_time: ~T[15:01:01], takeaway: false, dine_in: false, delivery: false}

      assert {:ok, %BussinessHour{} = bussiness_hour} = BusinessHours.update_bussiness_hour(bussiness_hour, update_attrs)
      assert bussiness_hour.day == :lunes
      assert bussiness_hour.open_time == ~T[15:01:01]
      assert bussiness_hour.close_time == ~T[15:01:01]
      assert bussiness_hour.takeaway == false
      assert bussiness_hour.dine_in == false
      assert bussiness_hour.delivery == false
    end

    test "update_bussiness_hour/2 with invalid data returns error changeset" do
      bussiness_hour = bussiness_hour_fixture()
      assert {:error, %Ecto.Changeset{}} = BusinessHours.update_bussiness_hour(bussiness_hour, @invalid_attrs)
      assert bussiness_hour == BusinessHours.get_bussiness_hour!(bussiness_hour.id)
    end

    test "delete_bussiness_hour/1 deletes the bussiness_hour" do
      bussiness_hour = bussiness_hour_fixture()
      assert {:ok, %BussinessHour{}} = BusinessHours.delete_bussiness_hour(bussiness_hour)
      assert_raise Ecto.NoResultsError, fn -> BusinessHours.get_bussiness_hour!(bussiness_hour.id) end
    end

    test "change_bussiness_hour/1 returns a bussiness_hour changeset" do
      bussiness_hour = bussiness_hour_fixture()
      assert %Ecto.Changeset{} = BusinessHours.change_bussiness_hour(bussiness_hour)
    end
  end
end
