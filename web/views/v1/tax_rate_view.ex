defmodule Store.V1.TaxRateView do
  use Store.Web, :view

  def render("index.json", %{tax_rates: tax_rates}) do
    %{data: render_many(tax_rates, Store.V1.TaxRateView, "tax_rate.json")}
  end

  def render("show.json", %{tax_rate: tax_rate}) do
    %{data: render_one(tax_rate, Store.V1.TaxRateView, "tax_rate.json")}
  end

  def render("tax_rate.json", %{tax_rate: tax_rate}) do
    %{id: tax_rate.id,
      country_id: tax_rate.country_id,
      percentage: tax_rate.percentage,
      start_date: tax_rate.start_date,
      end_date: tax_rate.end_date}
  end
end
