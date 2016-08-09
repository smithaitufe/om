defmodule Store.V1.InvoiceTypeView do
  use Store.Web, :view

  def render("index.json", %{invoice_types: invoice_types}) do
    %{data: render_many(invoice_types, Store.V1.InvoiceTypeView, "invoice_type.json")}
  end

  def render("show.json", %{invoice_type: invoice_type}) do
    %{data: render_one(invoice_type, Store.V1.InvoiceTypeView, "invoice_type.json")}
  end

  def render("invoice_type.json", %{invoice_type: invoice_type}) do
    %{id: invoice_type.id,
      name: invoice_type.name,
      slug: invoice_type.slug}
  end
end
