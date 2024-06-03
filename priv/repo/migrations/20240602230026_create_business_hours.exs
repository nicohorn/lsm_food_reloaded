defmodule LsmFoodReloaded.Repo.Migrations.CreateBusinessHours do
  use Ecto.Migration

  def change do
    create table(:business_hours) do
      add :name, :string
      add :active, :boolean, default: false, null: false
      add :business_id, references(:businesses, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:business_hours, [:business_id])
  end
end
