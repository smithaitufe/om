defmodule Store.V1.OrderView do
  use Store.Web, :view

  def render("index.json", %{orders: orders}) do
    render_many(orders, Store.V1.OrderView, "order.json")
  end

  def render("show.json", %{order: order}) do
    render_one(order, Store.V1.OrderView, "order.json")
  end

  def render("order.json", %{order: order}) do
    %{id: order.id,
      number: order.number,
      user_id: order.user_id,
      bill_address_id: order.bill_address_id,
      ship_address_id: order.ship_address_id,
      coupon_id: order.coupon_id,
      active: order.active}
  end
end
