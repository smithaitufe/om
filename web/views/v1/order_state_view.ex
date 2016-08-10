defmodule Store.V1.OrderStateView do
  use Store.Web, :view

  def render("index.json", %{order_states: order_states}) do
    render_many(order_states, Store.V1.OrderStateView, "order_state.json")
  end

  def render("show.json", %{order_state: order_state}) do
    render_one(order_state, Store.V1.OrderStateView, "order_state.json")
  end

  def render("order_state.json", %{order_state: order_state}) do
    %{id: order_state.id,
      order_id: order_state.order_id,
      order_status_id: order_state.order_status_id,
      active: order_state.active}
  end
end
