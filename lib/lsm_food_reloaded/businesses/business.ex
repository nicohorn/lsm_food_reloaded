defmodule LsmFoodReloaded.Businesses.Business do
  use Ecto.Schema
  import Ecto.Changeset

  schema "businesses" do
    field :enabled, :boolean, default: false
    field :name, :string
    field :address, :string
    field :description, :string
    field :image, :string
    field :phone_number, :integer
    field :socials,  :string
    field :featured, Ecto.Enum, values: [:premium, :sponsored, :basic]
    field :owner, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(business, attrs) do
    business
    |> cast(attrs, [:name, :description, :phone_number, :address, :socials, :featured, :enabled, :image])
    |> validate_required([:name, :description, :phone_number, :address, :socials, :featured, :enabled])
  end
end
