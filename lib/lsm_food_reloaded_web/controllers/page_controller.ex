defmodule LsmFoodReloadedWeb.PageController do
  use LsmFoodReloadedWeb, :controller

  alias LsmFoodReloaded.Accounts

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    IO.inspect(Accounts.get_all_users())
    render(conn, :home, layout: false)
  end
end
