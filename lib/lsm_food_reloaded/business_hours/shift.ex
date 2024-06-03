defmodule LsmFoodReloaded.BusinessHours.Shift do
  use Ecto.Schema
  import Ecto.Changeset

  schema "business_shifts" do
    field :start, :time
    field :end, :time
    field :modality, Ecto.Enum, values: [:"dine-in", :"take-away", :delivery]
    field :sunday, :boolean, default: false
    field :monday, :boolean, default: false
    field :tuesday, :boolean, default: false
    field :wednesday, :boolean, default: false
    field :thursday, :boolean, default: false
    field :friday, :boolean, default: false
    field :saturday, :boolean, default: false
    field :business_hour_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(shift, attrs) do
    shift
    |> cast(attrs, [:start, :end, :modality, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday])
    |> validate_required([:start, :end, :modality, :sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday])
  end
end
