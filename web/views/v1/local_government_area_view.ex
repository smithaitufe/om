defmodule Store.V1.LocalGovernmentAreaView do
  use Store.Web, :view

  def render("index.json", %{local_government_areas: local_government_areas}) do
    %{data: render_many(local_government_areas, Store.V1.LocalGovernmentAreaView, "local_government_area.json")}
  end

  def render("show.json", %{local_government_area: local_government_area}) do
    %{data: render_one(local_government_area, Store.V1.LocalGovernmentAreaView, "local_government_area.json")}
  end

  def render("local_government_area.json", %{local_government_area: local_government_area}) do
    %{id: local_government_area.id,
      name: local_government_area.name,
      state_id: local_government_area.state_id}
  end
end
