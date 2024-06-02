defmodule LsmFoodReloaded.BusinessesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `LsmFoodReloaded.Businesses` context.
  """

  @doc """
  Generate a business.
  """
  def business_fixture(attrs \\ %{}) do
    {:ok, business} =
      attrs
      |> Enum.into(%{
        address: "some address",
        description: "some description",
        enabled: true,
        featured: :premium,
        image: "some image",
        name: "some name",
        phone_number: 42,
        socials: ["option1", "option2"]
      })
      |> LsmFoodReloaded.Businesses.create_business()

    business
  end
end
