defmodule Store.V1.UserTypeView do
  use Store.Web, :view

  def render("index.json", %{user_types: user_types}) do
    render_many(user_types, Store.V1.UserTypeView, "user_type.json")
  end

  def render("show.json", %{user_type: user_type}) do
    render_one(user_type, Store.V1.UserTypeView, "user_type.json")
  end

  def render("user_type.json", %{user_type: user_type}) do
    %{id: user_type.id,
      name: user_type.name,
      description: user_type.description,
      code: user_type.code}
  end
end
