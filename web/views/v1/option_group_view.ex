defmodule Store.V1.OptionGroupView do
  use Store.Web, :view

  def render("index.json", %{option_groups: option_groups}) do
    %{data: render_many(option_groups, Store.V1.OptionGroupView, "option_group.json")}
  end

  def render("show.json", %{option_group: option_group}) do
    %{data: render_one(option_group, Store.V1.OptionGroupView, "option_group.json")}
  end

  def render("option_group.json", %{option_group: option_group}) do
    %{id: option_group.id,
      shop_id: option_group.shop_id,
      name: option_group.name}
  end
end
