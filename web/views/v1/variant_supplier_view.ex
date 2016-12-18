defmodule Store.V1.VariantSupplierView do
  use Store.Web, :view

  def render("index.json", %{variant_suppliers: variant_suppliers}) do
    render_many(variant_suppliers, Store.V1.VariantSupplierView, "variant_supplier.json")
  end

  def render("show.json", %{variant_supplier: variant_supplier}) do
    render_one(variant_supplier, Store.V1.VariantSupplierView, "variant_supplier.json")
  end

  def render("variant_supplier.json", %{variant_supplier: variant_supplier}) do
    %{id: variant_supplier.id,
      variant_id: variant_supplier.variant_id,
      supplier_id: variant_supplier.supplier_id,
      cost: variant_supplier.cost,
      total_quantity_supplied: variant_supplier.total_quantity_supplied,
      min_quantity: variant_supplier.min_quantity,
      max_quantity: variant_supplier.max_quantity,
      active: variant_supplier.active}
  end
end
