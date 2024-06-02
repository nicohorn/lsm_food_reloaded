defmodule LsmFoodReloaded.Repo.Migrations.CreateBusinesses do
  use Ecto.Migration

  def change do
    create table(:businesses) do
      add :name, :string
      add :description, :string
      add :phone_number, :integer
      add :address, :string
      add :socials, {:array, :string}
      add :featured, :string
      add :enabled, :boolean, default: false, null: false
      add :image, :string
      add :owner, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:businesses, [:owner])
  end
end
