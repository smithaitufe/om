defmodule Store.V1.VariantPropertyView do
  use Store.Web, :view

  def render("index.json", %{variant_properties: variant_properties}) do
    render_many(variant_properties, Store.V1.VariantPropertyView, "variant_property.json")
  end

  def render("show.json", %{variant_property: variant_property}) do
    render_one(variant_property, Store.V1.VariantPropertyView, "variant_property.json")
  end

  def render("variant_property.json", %{variant_property: variant_property}) do
    %{id: variant_property.id,
      variant_id: variant_property.variant_id,
      property_id: variant_property.property_id,
      description: variant_property.description,
      primary: variant_property.primary}
  end
end
