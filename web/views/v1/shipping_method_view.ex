defmodule Store.V1.ShippingMethodView do
  use Store.Web, :view

  def render("index.json", %{shipping_methods: shipping_methods}) do
    render_many(shipping_methods, Store.V1.ShippingMethodView, "shipping_method.json")
  end

  def render("show.json", %{shipping_method: shipping_method}) do
    render_one(shipping_method, Store.V1.ShippingMethodView, "shipping_method.json")
  end

  def render("shipping_method.json", %{shipping_method: shipping_method}) do
    %{id: shipping_method.id,
      name: shipping_method.name,
      shipping_zone_id: shipping_method.shipping_zone_id}
  end
end
