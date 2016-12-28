defmodule Store.V1.ShopUserView do
  use Store.Web, :view

  def render("index.json", %{shop_users: shop_users}) do
    %{data: render_many(shop_users, Store.V1.ShopUserView, "shop_user.json")}
  end

  def render("show.json", %{shop_user: shop_user}) do
    %{data: render_one(shop_user, Store.V1.ShopUserView, "shop_user.json")}
  end

  def render("shop_user.json", %{shop_user: shop_user}) do
    %{id: shop_user.id,
      shop_id: shop_user.shop_id,
      user_id: shop_user.user_id}
  end
end
