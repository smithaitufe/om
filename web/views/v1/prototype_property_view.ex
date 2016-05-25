defmodule Store.V1.PrototypePropertyView do
  use Store.Web, :view

  def render("index.json", %{prototype_properties: prototype_properties}) do
    %{data: render_many(prototype_properties, Store.V1.PrototypePropertyView, "prototype_property.json")}
  end

  def render("show.json", %{prototype_property: prototype_property}) do
    %{data: render_one(prototype_property, Store.V1.PrototypePropertyView, "prototype_property.json")}
  end

  def render("prototype_property.json", %{prototype_property: prototype_property}) do
    %{id: prototype_property.id,
      prototype_id: prototype_property.prototype_id,
      property_id: prototype_property.property_id}
  end
end
