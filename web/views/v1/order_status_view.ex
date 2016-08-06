defmodule Store.V1.OrderStatusView do
  use Store.Web, :view

  def render("index.json", %{order_statuses: order_statuses}) do
    render_many(order_statuses, Store.V1.OrderStatusView, "order_status.json")
  end

  def render("show.json", %{order_status: order_status}) do
    render_one(order_status, Store.V1.OrderStatusView, "order_status.json")
  end

  def render("order_status.json", %{order_status: order_status}) do
    %{id: order_status.id,
      order_id: order_status.order_id,
      order_status_type_id: order_status.order_status_type_id,
      active: order_status.active}
  end
end
