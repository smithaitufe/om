defmodule Store.V1.PaymentView do
  use Store.Web, :view

  def render("index.json", %{payments: payments}) do
    %{data: render_many(payments, Store.V1.PaymentView, "payment.json")}
  end

  def render("show.json", %{payment: payment}) do
    %{data: render_one(payment, Store.V1.PaymentView, "payment.json")}
  end

  def render("payment.json", %{payment: payment}) do
    %{id: payment.id,
      invoice_id: payment.invoice_id,
      payment_method_id: payment.payment_method_id,
      success: payment.success,
      cleared: payment.cleared,
      cleared_by_user_id: payment.cleared_by_user_id,
      error_code: payment.error_code,
      error: payment.error}
  end
end
