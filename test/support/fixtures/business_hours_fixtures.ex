defmodule LsmFoodReloaded.BusinessHoursFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LsmFoodReloaded.BusinessHours` context.
  """

  @doc """
  Generate a bussiness_hour.
  """
  def bussiness_hour_fixture(attrs \\ %{}) do
    {:ok, bussiness_hour} =
      attrs
      |> Enum.into(%{
        close_time: ~T[14:00:00],
        day: :domingo,
        delivery: true,
        dine_in: true,
        open_time: ~T[14:00:00],
        takeaway: true
      })
      |> LsmFoodReloaded.BusinessHours.create_bussiness_hour()

    bussiness_hour
  end
end
