defmodule Store.V1.UserController do
  use Store.Web, :controller
  plug :scrub_params, "user" when action in [:create]
  alias Store.{Repo, User}

  def index(conn, params) do
    users = User
    |> build_query_filters(Map.to_list(params))
    |> Repo.all()
    |> Repo.preload(User.associations)

    render(conn, "index.json", users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User,id)
    render(conn, "show.json", user: user)
  end


  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)
    case Repo.insert(changeset) do
      {:ok, user} ->
        {:ok, jwt, _full_claims} = Guardian.encode_and_sign(user, :token)

        conn
        |> put_status(:created)
        |> render(Store.V1.SessionView, "show.json", jwt: jwt, user: user)

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render("error.json", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get!(User, id)
    changeset = User.changeset(user, user_params)

    case Repo.update(changeset) do
      {:ok, user} ->
        render(conn, "show.json", user: user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  defp build_query_filters(query, []), do: query
  defp build_query_filters(query, [{"user_type_id", user_type_id} |  tail ]) do
    query
    |> Ecto.Query.where([q], q.user_type_id == ^user_type_id)
    |> build_query_filters(tail)
  end


end
