defmodule Store.V1.PrototypeView do
  use Store.Web, :view

  def render("index.json", %{prototypes: prototypes}) do
    render_many(prototypes, Store.V1.PrototypeView, "prototype.json")
  end

  def render("show.json", %{prototype: prototype}) do
    render_one(prototype, Store.V1.PrototypeView, "prototype.json")
  end

  def render("prototype.json", %{prototype: prototype}) do
    %{id: prototype.id,
      name: prototype.name,
      active: prototype.active}
  end
end
