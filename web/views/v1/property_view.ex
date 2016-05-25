defmodule Store.V1.PropertyView do
  use Store.Web, :view

  def render("index.json", %{properties: properties}) do
    %{data: render_many(properties, Store.V1.PropertyView, "property.json")}
  end

  def render("show.json", %{property: property}) do
    %{data: render_one(property, Store.V1.PropertyView, "property.json")}
  end

  def render("property.json", %{property: property}) do
    %{id: property.id,
      display_name: property.display_name,
      identifying_name: property.identifying_name,
      active: property.active}
  end
end
