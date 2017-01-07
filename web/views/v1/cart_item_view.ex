defmodule Store.V1.CartItemView do
  use Store.Web, :view

  def render("index.json", %{cart_items: cart_items}) do
    render_many(cart_items, Store.V1.CartItemView, "cart_item.json")
  end

  def render("show.json", %{cart_item: cart_item}) do
    render_one(cart_item, Store.V1.CartItemView, "cart_item.json")
  end

  def render("cart_item.json", %{cart_item: cart_item}) do
    %{id: cart_item.id,
      cart_id: cart_item.cart_id,
      variant_id: cart_item.variant_id,
      quantity: cart_item.quantity,
      active: cart_item.active,      
      item_type_id: cart_item.item_type_id,
      inserted_at: cart_item.inserted_at
    }
      |> Map.put(:variant, render_one(cart_item.variant, Store.V1.VariantView, "variant.json"))
  end
end
