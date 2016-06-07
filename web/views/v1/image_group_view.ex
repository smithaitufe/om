defmodule Store.V1.ImageGroupView do
  use Store.Web, :view

  def render("index.json", %{image_groups: image_groups}) do
    %{data: render_many(image_groups, Store.V1.ImageGroupView, "image_group.json")}
  end

  def render("show.json", %{image_group: image_group}) do
    %{data: render_one(image_group, Store.V1.ImageGroupView, "image_group.json")}
  end

  def render("image_group.json", %{image_group: image_group}) do
    %{id: image_group.id,
      name: image_group.name,
      product_id: image_group.product_id}
  end
end
