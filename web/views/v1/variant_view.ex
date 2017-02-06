defmodule Store.V1.VariantView do
  use Store.Web, :view

  def render("index.json", %{variants: variants}) do
    render_many(variants, Store.V1.VariantView, "variant.json")
  end

  def render("show.json", %{variant: variant}) do
    render_one(variant, Store.V1.VariantView, "variant.json")
  end

  def render("variant.json", %{variant: variant}) do
    %{
      id: variant.id,
      product_id: variant.product_id,
      sku: variant.sku,
      name: variant.name,
      price: variant.price,
      compare_price: variant.compare_price,
      master: variant.master,      
      deleted_at: variant.deleted_at,
      weight: variant.weight
    }
  end
end
