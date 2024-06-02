defmodule LsmFoodReloadedWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use LsmFoodReloadedWeb, :controller` and
  `use LsmFoodReloadedWeb, :live_view`.
  """
  use LsmFoodReloadedWeb, :html

  embed_templates "layouts/*"
end
