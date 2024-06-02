defmodule LsmFoodReloaded.BusinessHours.BusinessHour do
  use Ecto.Schema
  import Ecto.Changeset

  schema "business_hours" do
    field :active, :boolean, default: false
    field :name, :string
    field :business_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(business_hour, attrs) do
    business_hour
    |> cast(attrs, [:name, :active])
    |> validate_required([:name, :active])
  end
end
