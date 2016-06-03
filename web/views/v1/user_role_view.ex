defmodule Store.V1.UserRoleView do
  use Store.Web, :view

  def render("index.json", %{user_roles: user_roles}) do
    %{data: render_many(user_roles, Store.V1.UserRoleView, "user_role.json")}
  end

  def render("show.json", %{user_role: user_role}) do
    %{data: render_one(user_role, Store.V1.UserRoleView, "user_role.json")}
  end

  def render("user_role.json", %{user_role: user_role}) do
    %{id: user_role.id,
      user_id: user_role.user_id,
      role_id: user_role.role_id}
  end
end
