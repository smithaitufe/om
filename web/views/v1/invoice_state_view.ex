defmodule Store.V1.InvoiceStateView do
  use Store.Web, :view

  def render("index.json", %{invoice_states: invoice_states}) do
    %{data: render_many(invoice_states, Store.V1.InvoiceStateView, "invoice_state.json")}
  end

  def render("show.json", %{invoice_state: invoice_state}) do
    %{data: render_one(invoice_state, Store.V1.InvoiceStateView, "invoice_state.json")}
  end

  def render("invoice_state.json", %{invoice_state: invoice_state}) do
    %{id: invoice_state.id,
      invoice_id: invoice_state.invoice_id,
      invoice_status_id: invoice_state.invoice_status_id,
      user_id: invoice_state.user_id,
      active: invoice_state.active}
  end
end
