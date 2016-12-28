defmodule Store.V1.CartView do
  use Store.Web, :view

  def render("index.json", %{carts: carts}) do
    render_many(carts, Store.V1.CartView, "cart.json")
  end

  def render("show.json", %{cart: cart}) do
    render_one(cart, Store.V1.CartView, "cart.json")
  end

  def render("cart.json", %{cart: cart}) do
    %{id: cart.id,
      user_id: cart.user_id}
      |> Map.put(:cart_items, render_many(cart.cart_items, Store.V1.CartItemView, "cart_item.json"))
  end
end