defmodule Store.V1.SessionController do
  use Store.Web, :controller
  alias Store.{Session}
  plug :scrub_params, "session" when action in [:create]

  def create(conn, %{"session" => session_params}) do

    case Store.Helper.Session.authenticate(session_params) do
      {:ok, user} ->

        {:ok, jwt, _full_claims} = user |> Guardian.encode_and_sign(:token)

        # changeset = Session.changeset(%Session{}, %{user_id: user.id, token: jwt})
        # if changeset.valid? do
        #   Repo.insert(changeset)
        # end

        roles = user
        |> assoc(:roles)
        |> Repo.all

        conn
        |> put_status(:created)
        |> render("show.json", jwt: jwt, user: user, roles: roles)

      {:error, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json")
    end
  end

  def delete(conn, _) do
    {:ok, claims} = Guardian.Plug.claims(conn)

    conn
    |> Guardian.Plug.current_token
    |> Guardian.revoke!(claims)

    conn
    |> render("delete.json")
  end

  def unauthenticated(conn, _params) do
    conn
    |> put_status(:forbidden)
    |> render(Store.V1.SessionView, "forbidden.json", error: "Not Authenticated")
  end
end