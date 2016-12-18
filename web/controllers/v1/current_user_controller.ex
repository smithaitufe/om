defmodule Store.V1.CurrentUserController do
  use Store.Web, :controller

  plug Guardian.Plug.EnsureAuthenticated, handler: Store.V1.SessionController

  def show(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    conn
    |> put_status(:ok)
    |> render("show.json", user: user)
  end
end
