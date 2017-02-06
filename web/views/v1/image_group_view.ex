defmodule Store.V1.ImageGroupView do
  use Store.Web, :view

  def render("index.json", %{image_groups: image_groups}) do
    render_many(image_groups, Store.V1.ImageGroupView, "image_group.json")
  end

  def render("show.json", %{image_group: image_group}) do
    render_one(image_group, Store.V1.ImageGroupView, "image_group.json")
  end

  def render("image_group.json", %{image_group: image_group}) do
    %{id: image_group.id,
      name: image_group.name,
      product_id: image_group.product_id}
      |> Map.put(:product, render_one(image_group.product, Store.V1.ProductView, "product_lite.json"))
  end
end
