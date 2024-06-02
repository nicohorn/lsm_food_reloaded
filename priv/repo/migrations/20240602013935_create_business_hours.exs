defmodule LsmFoodReloaded.Repo.Migrations.CreateBusinessHours do
  use Ecto.Migration

  def change do
    create table(:business_hours) do
      add :day, :string
      add :open_time, :time
      add :close_time, :time
      add :takeaway, :boolean, default: false, null: false
      add :dine_in, :boolean, default: false, null: false
      add :delivery, :boolean, default: false, null: false
      add :business_id, references(:business, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:business_hours, [:business_id])
  end
end
