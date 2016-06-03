defmodule Store.V1.CartView do
  use Store.Web, :view

  def render("index.json", %{carts: carts}) do
    %{data: render_many(carts, Store.V1.CartView, "cart.json")}
  end

  def render("show.json", %{cart: cart}) do
    %{data: render_one(cart, Store.V1.CartView, "cart.json")}
  end

  def render("cart.json", %{cart: cart}) do
    %{id: cart.id,
      user_id: cart.user_id}
  end
end
