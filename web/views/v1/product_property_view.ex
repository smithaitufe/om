defmodule Store.V1.ProductPropertyView do
  use Store.Web, :view

  def render("index.json", %{product_properties: product_properties}) do
    render_many(product_properties, Store.V1.ProductPropertyView, "product_property.json")
  end

  def render("show.json", %{product_property: product_property}) do
    render_one(product_property, Store.V1.ProductPropertyView, "product_property.json")
  end

  def render("product_property.json", %{product_property: product_property}) do
    %{id: product_property.id,
      product_id: product_property.product_id,
      property_id: product_property.property_id,
      position: product_property.position,
      description: product_property.description}
  end
end
