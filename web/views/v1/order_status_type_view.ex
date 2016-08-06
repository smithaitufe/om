defmodule Store.V1.OrderStatusTypeView do
  use Store.Web, :view

  def render("index.json", %{order_status_types: order_status_types}) do
    render_many(order_status_types, Store.V1.OrderStatusTypeView, "order_status_type.json")
  end

  def render("show.json", %{order_status_type: order_status_type}) do
    render_one(order_status_type, Store.V1.OrderStatusTypeView, "order_status_type.json")
  end

  def render("order_status_type.json", %{order_status_type: order_status_type}) do
    %{id: order_status_type.id,
      name: order_status_type.name}
  end
end
