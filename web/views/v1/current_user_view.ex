defmodule Store.V1.CurrentUserView do
  use Store.Web, :view

  def render("show.json", %{user: user}) do
    render_one(user, Store.V1.CurrentUserView, "user.json")
  end
  def render("user.json", %{user: user}) do
    %{
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        active: user.active
      }
  end

  def render("error.json", _) do
  end
end
