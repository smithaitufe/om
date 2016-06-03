defmodule Store.V1.RoleView do
  use Store.Web, :view

  def render("index.json", %{roles: roles}) do
    %{data: render_many(roles, Store.V1.RoleView, "role.json")}
  end

  def render("show.json", %{role: role}) do
    %{data: render_one(role, Store.V1.RoleView, "role.json")}
  end

  def render("role.json", %{role: role}) do
    %{id: role.id,
      name: role.name}
  end
end
