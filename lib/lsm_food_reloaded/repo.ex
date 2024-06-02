defmodule LsmFoodReloaded.Repo do
  use Ecto.Repo,
    otp_app: :lsm_food_reloaded,
    adapter: Ecto.Adapters.SQLite3
end
