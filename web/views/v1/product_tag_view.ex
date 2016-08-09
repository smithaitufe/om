defmodule Store.V1.ProductTagView do
  use Store.Web, :view

  def render("index.json", %{product_tags: product_tags}) do
    %{data: render_many(product_tags, Store.V1.ProductTagView, "product_tag.json")}
  end

  def render("show.json", %{product_tag: product_tag}) do
    %{data: render_one(product_tag, Store.V1.ProductTagView, "product_tag.json")}
  end

  def render("product_tag.json", %{product_tag: product_tag}) do
    %{id: product_tag.id,
      product_id: product_tag.product_id,
      tag_id: product_tag.tag_id}
  end
end
