defmodule LsmFoodReloaded.Repo.Migrations.CreateBusinessShifts do
  use Ecto.Migration

  def change do
    create table(:business_shifts) do
      add :start, :time
      add :end, :time
      add :modality, :string
      add :sunday, :boolean, default: false, null: false
      add :monday, :boolean, default: false, null: false
      add :tuesday, :boolean, default: false, null: false
      add :wednesday, :boolean, default: false, null: false
      add :thursday, :boolean, default: false, null: false
      add :friday, :boolean, default: false, null: false
      add :saturday, :boolean, default: false, null: false
      add :business_hour_id, references(:business_hours, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:business_shifts, [:business_hour_id])
  end
end
