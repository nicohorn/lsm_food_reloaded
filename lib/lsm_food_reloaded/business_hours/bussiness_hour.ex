defmodule LsmFoodReloaded.BusinessHours.BussinessHour do
  use Ecto.Schema
  import Ecto.Changeset

  schema "business_hours" do
    field :day, Ecto.Enum, values: [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]
    field :open_time, :time
    field :close_time, :time
    field :takeaway, :boolean, default: false
    field :dine_in, :boolean, default: false
    field :delivery, :boolean, default: false
    field :business_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(bussiness_hour, attrs) do
    bussiness_hour
    |> cast(attrs, [:day, :open_time, :close_time, :takeaway, :dine_in, :delivery])
    |> validate_required([:day, :open_time, :close_time, :takeaway, :dine_in, :delivery])
  end
end
