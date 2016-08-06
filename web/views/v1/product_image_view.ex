defmodule Store.V1.ProductImageView do
  use Store.Web, :view

  def render("index.json", %{product_images: product_images}) do
    render_many(product_images, Store.V1.ProductImageView, "product_image.json")
  end

  def render("show.json", %{product_image: product_image}) do
    render_one(product_image, Store.V1.ProductImageView, "product_image.json")
  end

  def render("product_image.json", %{product_image: product_image}) do
    %{id: product_image.id,
      product_id: product_image.product_id,
      image_id: product_image.image_id}
  end
end
