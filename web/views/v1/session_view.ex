defmodule Store.V1.SessionView do
  use Store.Web, :view
  def render("show.json", %{token: token, user: user, roles: roles}) do
     %{
        user: %{
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        active: user.active,
        roles: render_many(roles, Store.V1.RoleView, "role.json")
        },
        token: token
      }     
    
  end
  def render("show.json", %{jwt: jwt, user: user}) do
    %{data:
      %{
        user: %{
        id: user.id,
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        active: user.active
        },
        jwt: jwt
      }

    }
  end


  defp render_roles(json, %{roles: roles}) do
    Map.put(json, :roles, render_many(roles, ComputerBasedTest.V1.TermView, "term.json"))
  end

  def render("error.json", _) do
    %{error: "Invalid email or password"}
  end

  def render("delete.json", _) do
    %{ok: true}
  end

  def render("forbidden.json", %{error: error}) do
    %{error: error}
  end
end
