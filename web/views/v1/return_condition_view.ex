defmodule Store.V1.ReturnConditionView do
  use Store.Web, :view

  def render("index.json", %{return_conditions: return_conditions}) do
    %{data: render_many(return_conditions, Store.V1.ReturnConditionView, "return_condition.json")}
  end

  def render("show.json", %{return_condition: return_condition}) do
    %{data: render_one(return_condition, Store.V1.ReturnConditionView, "return_condition.json")}
  end

  def render("return_condition.json", %{return_condition: return_condition}) do
    %{id: return_condition.id,
      label: return_condition.label,
      description: return_condition.description}
  end
end
