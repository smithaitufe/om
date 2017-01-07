defmodule Store.V1.ItemTypeView do
  use Store.Web, :view

  def render("index.json", %{item_types: item_types}) do
    render_many(item_types, Store.V1.ItemTypeView, "item_type.json")
  end

  def render("show.json", %{item_type: item_type}) do
    render_one(item_type, Store.V1.ItemTypeView, "item_type.json")
  end

  def render("item_type.json", %{item_type: item_type}) do
    %{id: item_type.id,
      name: item_type.name,
      description: item_type.description
    }
  end
end
