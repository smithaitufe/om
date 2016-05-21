defmodule Store.V1.ProductCategoryView do
  use Store.Web, :view

  def render("index.json", %{product_categories: product_categories}) do
    %{data: render_many(product_categories, Store.V1.ProductCategoryView, "product_category.json")}
  end

  def render("show.json", %{product_category: product_category}) do
    %{data: render_one(product_category, Store.V1.ProductCategoryView, "product_category.json")}
  end

  def render("product_category.json", %{product_category: product_category}) do
    %{id: product_category.id,
      name: product_category.name,
      description: product_category.description,
      parent_id: product_category.parent_id,
      active: product_category.active}
  end
end
