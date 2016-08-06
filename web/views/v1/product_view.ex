defmodule Store.V1.ProductView do
  use Store.Web, :view

  def render("index.json", %{products: products}) do
    render_many(products, Store.V1.ProductView, "product.json")
  end

  def render("show.json", %{product: product}) do
    render_one(product, Store.V1.ProductView, "product.json")
  end

  def render("product.json", %{product: product}) do
    %{id: product.id,
      shop_id: product.shop_id,
      brand_id: product.brand_id,
      name: product.name,
      short_description: product.short_description,
      long_description: product.long_description,
      product_category_id: product.product_category_id,
      shipping_category_id: product.shipping_category_id,
      available_at: product.available_at,
      deleted_at: product.deleted_at,
      permalink: product.permalink,
      keywords: product.keywords,
      featured: product.featured}
  end
end
