defmodule Store.V1.MerchantView do
  use Store.Web, :view

  def render("index.json", %{merchants: merchants}) do
    %{data: render_many(merchants, Store.V1.MerchantView, "merchant.json")}
  end

  def render("show.json", %{merchant: merchant}) do
    %{data: render_one(merchant, Store.V1.MerchantView, "merchant.json")}
  end

  def render("merchant.json", %{merchant: merchant}) do
    %{id: merchant.id,
      name: merchant.name,
      phone_number: merchant.phone_number,
      email: merchant.email}
  end
end
