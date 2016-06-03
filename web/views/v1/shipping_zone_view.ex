defmodule Store.V1.ShippingZoneView do
  use Store.Web, :view

  def render("index.json", %{shipping_zones: shipping_zones}) do
    %{data: render_many(shipping_zones, Store.V1.ShippingZoneView, "shipping_zone.json")}
  end

  def render("show.json", %{shipping_zone: shipping_zone}) do
    %{data: render_one(shipping_zone, Store.V1.ShippingZoneView, "shipping_zone.json")}
  end

  def render("shipping_zone.json", %{shipping_zone: shipping_zone}) do
    %{id: shipping_zone.id,
      name: shipping_zone.name}
  end
end
