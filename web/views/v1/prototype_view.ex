defmodule Store.V1.PrototypeView do
  use Store.Web, :view

  def render("index.json", %{prototypes: prototypes}) do
    render_many(prototypes, Store.V1.PrototypeView, "prototype.json")
  end

  def render("show.json", %{prototype: prototype}) do
    render_one(prototype, Store.V1.PrototypeView, "prototype.json")
  end

  def render("prototype.json", %{prototype: prototype}) do
    %{
      id: prototype.id,
      shop_id: prototype.shop_id,
      name: prototype.name,
      active: prototype.active
    }
    |> Map.put(:properties, render_many(prototype.properties, Store.V1.PropertyView, "property.json"))
  end
end
