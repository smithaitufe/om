defmodule Store.V1.ShopView do
  use Store.Web, :view

  def render("index.json", %{shops: shops}) do
    render_many(shops, Store.V1.ShopView, "shop.json")
  end

  def render("show.json", %{shop: shop}) do
    render_one(shop, Store.V1.ShopView, "shop.json")
  end

  def render("shop.json", %{shop: shop}) do
    %{id: shop.id,
      name: shop.name,
      phone_number: shop.phone_number,
      email: shop.email,
      user_id: shop.user_id}
  end
end
