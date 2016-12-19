defmodule Store.V1.UserTypeController do
  use Store.Web, :controller

  alias Store.UserType

  plug :scrub_params, "user_type" when action in [:create, :update]

  def index(conn, _params) do
    user_types = Repo.all(UserType)
    render(conn, "index.json", user_types: user_types)
  end

  def create(conn, %{"user_type" => user_type_params}) do
    changeset = UserType.changeset(%UserType{}, user_type_params)

    case Repo.insert(changeset) do
      {:ok, user_type} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_user_type_path(conn, :show, user_type))
        |> render("show.json", user_type: user_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_type = Repo.get!(UserType, id)
    render(conn, "show.json", user_type: user_type)
  end

  def update(conn, %{"id" => id, "user_type" => user_type_params}) do
    user_type = Repo.get!(UserType, id)
    changeset = UserType.changeset(user_type, user_type_params)

    case Repo.update(changeset) do
      {:ok, user_type} ->
        render(conn, "show.json", user_type: user_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_type = Repo.get!(UserType, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_type)

    send_resp(conn, :no_content, "")
  end
end
