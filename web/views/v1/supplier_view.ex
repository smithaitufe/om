defmodule Store.V1.SupplierView do
  use Store.Web, :view

  def render("index.json", %{suppliers: suppliers}) do
    render_many(suppliers, Store.V1.SupplierView, "supplier.json")
  end

  def render("show.json", %{supplier: supplier}) do
    render_one(supplier, Store.V1.SupplierView, "supplier.json")
  end

  def render("supplier.json", %{supplier: supplier}) do
    %{id: supplier.id,
      name: supplier.name,
      email: supplier.email,
      phone_number: supplier.phone_number}
  end
end
