defmodule Store.V1.ShippingCategoryView do
  use Store.Web, :view

  def render("index.json", %{shipping_categories: shipping_categories}) do
    render_many(shipping_categories, Store.V1.ShippingCategoryView, "shipping_category.json")
  end

  def render("show.json", %{shipping_category: shipping_category}) do
    render_one(shipping_category, Store.V1.ShippingCategoryView, "shipping_category.json")
  end

  def render("shipping_category.json", %{shipping_category: shipping_category}) do
    %{id: shipping_category.id,
      name: shipping_category.name,
      description: shipping_category.description}
  end
end
