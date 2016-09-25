defmodule Store.V1.ShippingRateView do
  use Store.Web, :view

  def render("index.json", %{shipping_rates: shipping_rates}) do
    %{data: render_many(shipping_rates, Store.V1.ShippingRateView, "shipping_rate.json")}
  end

  def render("show.json", %{shipping_rate: shipping_rate}) do
    %{data: render_one(shipping_rate, Store.V1.ShippingRateView, "shipping_rate.json")}
  end

  def render("shipping_rate.json", %{shipping_rate: shipping_rate}) do
    %{id: shipping_rate.id,
      payment_method_id: shipping_rate.payment_method_id,
      shipping_method_id: shipping_rate.shipping_method_id,
      shipping_rate_type_id: shipping_rate.shipping_rate_type_id,
      minimum: shipping_rate.minimum,
      maximum: shipping_rate.maximum,
      rate: shipping_rate.rate,
      active: shipping_rate.active}
  end
end
