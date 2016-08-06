defmodule Store.V1.BrandView do
  use Store.Web, :view

  def render("index.json", %{brands: brands}) do
    render_many(brands, Store.V1.BrandView, "brand.json")
  end

  def render("show.json", %{brand: brand}) do
    render_one(brand, Store.V1.BrandView, "brand.json")
  end

  def render("brand.json", %{brand: brand}) do
    %{id: brand.id,
      name: brand.name}
  end
end
