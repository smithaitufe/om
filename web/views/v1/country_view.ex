defmodule Store.V1.CountryView do
  use Store.Web, :view

  def render("index.json", %{countries: countries}) do
    render_many(countries, Store.V1.CountryView, "country.json")
  end

  def render("show.json", %{country: country}) do
    render_one(country, Store.V1.CountryView, "country.json")
  end

  def render("country.json", %{country: country}) do
    %{id: country.id,
      name: country.name,
      abbreviation: country.abbreviation
      }
  end
end
