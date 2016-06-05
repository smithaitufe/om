defmodule Store.V1.StateView do
  use Store.Web, :view

  def render("index.json", %{states: states}) do
    %{data: render_many(states, Store.V1.StateView, "state.json")}
  end

  def render("show.json", %{state: state}) do
    %{data: render_one(state, Store.V1.StateView, "state.json")}
  end

  def render("state.json", %{state: state}) do
    %{id: state.id,
      country_id: state.country_id,
      name: state.name,
      described_as: state.described_as,
      abbreviation: state.abbreviation,
      shipping_zone_id: state.shipping_zone_id}
  end
end
