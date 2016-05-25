defmodule Store.V1.VariantView do
  use Store.Web, :view

  def render("index.json", %{variants: variants}) do
    %{data: render_many(variants, Store.V1.VariantView, "variant.json")}
  end

  def render("show.json", %{variant: variant}) do
    %{data: render_one(variant, Store.V1.VariantView, "variant.json")}
  end

  def render("variant.json", %{variant: variant}) do
    %{id: variant.id,
      product_id: variant.product_id,
      sku: variant.sku,
      name: variant.name,
      price: variant.price,
      compare_price: variant.compare_price,
      master: variant.master,
      quantity_on_hand: variant.quantity_on_hand,
      quantity_pending_to_customer: variant.quantity_pending_to_customer,
      quantity_pending_from_supplier: variant.quantity_pending_from_supplier,
      deleted_at: variant.deleted_at}
  end
end
