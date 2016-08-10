defmodule Store.V1.InvoiceView do
  use Store.Web, :view

  def render("index.json", %{invoices: invoices}) do
    %{data: render_many(invoices, Store.V1.InvoiceView, "invoice.json")}
  end

  def render("show.json", %{invoice: invoice}) do
    %{data: render_one(invoice, Store.V1.InvoiceView, "invoice.json")}
  end

  def render("invoice.json", %{invoice: invoice}) do
    %{id: invoice.id,
      order_id: invoice.order_id,
      invoice_type_id: invoice.invoice_type_id,
      invoice_status_id: invoice.invoice_status_id,
      number: invoice.number,
      amount: invoice.amount,
      active: invoice.active,
      created_by_user_id: invoice.created_by_user_id}
  end
end
