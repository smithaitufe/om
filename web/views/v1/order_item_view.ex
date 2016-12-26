defmodule Store.V1.OrderItemView do
  use Store.Web, :view

  def render("index.json", %{order_items: order_items}) do
    %{data: render_many(order_items, Store.V1.OrderItemView, "order_item.json")}
  end

  def render("show.json", %{order_item: order_item}) do
    %{data: render_one(order_item, Store.V1.OrderItemView, "order_item.json")}
  end

  def render("order_item.json", %{order_item: order_item}) do
    %{id: order_item.id,
      order_id: order_item.order_id,
      variant_id: order_item.variant_id,
      price: order_item.price,
      quantity: order_item.quantity,
      total: order_item.total,
      state: order_item.state}
  end
end
