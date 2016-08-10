defmodule Store.V1.InvoiceStatusView do
  use Store.Web, :view

  def render("index.json", %{invoice_statuses: invoice_statuses}) do
    render_many(invoice_statuses, Store.V1.InvoiceStatusView, "invoice_status.json")
  end

  def render("show.json", %{invoice_status: invoice_status}) do
    render_one(invoice_status, Store.V1.InvoiceStatusView, "invoice_status.json")
  end

  def render("invoice_status.json", %{invoice_status: invoice_status}) do
    %{id: invoice_status.id,
      name: invoice_status.name}
  end
end
