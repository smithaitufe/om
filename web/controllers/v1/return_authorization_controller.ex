defmodule Store.V1.ReturnAuthorizationController do
  use Store.Web, :controller

  alias Store.ReturnAuthorization

  plug :scrub_params, "return_authorization" when action in [:create, :update]

  def index(conn, _params) do
    return_authorizations = Repo.all(ReturnAuthorization)
    render(conn, "index.json", return_authorizations: return_authorizations)
  end

  def create(conn, %{"return_authorization" => return_authorization_params}) do
    changeset = ReturnAuthorization.changeset(%ReturnAuthorization{}, return_authorization_params)

    case Repo.insert(changeset) do
      {:ok, return_authorization} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_return_authorization_path(conn, :show, return_authorization))
        |> render("show.json", return_authorization: return_authorization)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    return_authorization = Repo.get!(ReturnAuthorization, id)
    render(conn, "show.json", return_authorization: return_authorization)
  end

  def update(conn, %{"id" => id, "return_authorization" => return_authorization_params}) do
    return_authorization = Repo.get!(ReturnAuthorization, id)
    changeset = ReturnAuthorization.changeset(return_authorization, return_authorization_params)

    case Repo.update(changeset) do
      {:ok, return_authorization} ->
        render(conn, "show.json", return_authorization: return_authorization)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    return_authorization = Repo.get!(ReturnAuthorization, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(return_authorization)

    send_resp(conn, :no_content, "")
  end
end
