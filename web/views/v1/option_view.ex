defmodule Store.V1.OptionView do
  use Store.Web, :view

  def render("index.json", %{options: options}) do
    render_many(options, Store.V1.OptionView, "option.json")
  end

  def render("show.json", %{option: option}) do
    render_one(option, Store.V1.OptionView, "option.json")
  end

  def render("option.json", %{option: option}) do
    %{id: option.id,
      option_group_id: option.option_group_id,
      name: option.name}
  end
end
