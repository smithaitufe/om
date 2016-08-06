defmodule Store.V1.PaymentMethodView do
  use Store.Web, :view

  def render("index.json", %{payment_methods: payment_methods}) do
    render_many(payment_methods, Store.V1.PaymentMethodView, "payment_method.json")
  end

  def render("show.json", %{payment_method: payment_method}) do
    render_one(payment_method, Store.V1.PaymentMethodView, "payment_method.json")
  end

  def render("payment_method.json", %{payment_method: payment_method}) do
    %{id: payment_method.id,
      name: payment_method.name}
  end
end
