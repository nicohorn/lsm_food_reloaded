defmodule LsmFoodReloaded.BusinessesTest do
  use LsmFoodReloaded.DataCase

  alias LsmFoodReloaded.Businesses

  describe "businesses" do
    alias LsmFoodReloaded.Businesses.Business

    import LsmFoodReloaded.BusinessesFixtures

    @invalid_attrs %{enabled: nil, name: nil, address: nil, description: nil, image: nil, phone_number: nil, socials: nil, featured: nil}

    test "list_businesses/0 returns all businesses" do
      business = business_fixture()
      assert Businesses.list_businesses() == [business]
    end

    test "get_business!/1 returns the business with given id" do
      business = business_fixture()
      assert Businesses.get_business!(business.id) == business
    end

    test "create_business/1 with valid data creates a business" do
      valid_attrs = %{enabled: true, name: "some name", address: "some address", description: "some description", image: "some image", phone_number: 42, socials: ["option1", "option2"], featured: :premium}

      assert {:ok, %Business{} = business} = Businesses.create_business(valid_attrs)
      assert business.enabled == true
      assert business.name == "some name"
      assert business.address == "some address"
      assert business.description == "some description"
      assert business.image == "some image"
      assert business.phone_number == 42
      assert business.socials == ["option1", "option2"]
      assert business.featured == :premium
    end

    test "create_business/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Businesses.create_business(@invalid_attrs)
    end

    test "update_business/2 with valid data updates the business" do
      business = business_fixture()
      update_attrs = %{enabled: false, name: "some updated name", address: "some updated address", description: "some updated description", image: "some updated image", phone_number: 43, socials: ["option1"], featured: :sponsored}

      assert {:ok, %Business{} = business} = Businesses.update_business(business, update_attrs)
      assert business.enabled == false
      assert business.name == "some updated name"
      assert business.address == "some updated address"
      assert business.description == "some updated description"
      assert business.image == "some updated image"
      assert business.phone_number == 43
      assert business.socials == ["option1"]
      assert business.featured == :sponsored
    end

    test "update_business/2 with invalid data returns error changeset" do
      business = business_fixture()
      assert {:error, %Ecto.Changeset{}} = Businesses.update_business(business, @invalid_attrs)
      assert business == Businesses.get_business!(business.id)
    end

    test "delete_business/1 deletes the business" do
      business = business_fixture()
      assert {:ok, %Business{}} = Businesses.delete_business(business)
      assert_raise Ecto.NoResultsError, fn -> Businesses.get_business!(business.id) end
    end

    test "change_business/1 returns a business changeset" do
      business = business_fixture()
      assert %Ecto.Changeset{} = Businesses.change_business(business)
    end
  end
end
