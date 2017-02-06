defmodule Store.V1.ProductConditionView do
  use Store.Web, :view

  def render("index.json", %{product_conditions: product_conditions}) do
    %{data: render_many(product_conditions, Store.V1.ProductConditionView, "product_condition.json")}
  end

  def render("show.json", %{product_condition: product_condition}) do
    %{data: render_one(product_condition, Store.V1.ProductConditionView, "product_condition.json")}
  end

  def render("product_condition.json", %{product_condition: product_condition}) do
    %{id: product_condition.id,
      name: product_condition.name}
  end
end
