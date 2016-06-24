defmodule Store.V1.CityView do
  use Store.Web, :view

  def render("index.json", %{cities: cities}) do
    %{data: render_many(cities, Store.V1.CityView, "city.json")}
  end

  def render("show.json", %{city: city}) do
    %{data: render_one(city, Store.V1.CityView, "city.json")}
  end

  def render("city.json", %{city: city}) do
    %{id: city.id,
      state_id: city.state_id,
      name: city.name}
  end
end
