defmodule Store.V1.OrderStatusView do
  use Store.Web, :view

  def render("index.json", %{order_statuss: order_statuses}) do
    render_many(order_statuses, Store.V1.OrderStatusView, "order_status.json")
  end

  def render("show.json", %{order_status: order_status}) do
    render_one(order_status, Store.V1.OrderStatusView, "order_status.json")
  end

  def render("order_status.json", %{order_status: order_status}) do
    %{id: order_status.id,
      name: order_status.name}
  end
end
