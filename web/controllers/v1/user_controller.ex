defmodule Store.V1.UserController do
  use Store.Web, :controller
  plug :scrub_params, "user" when action in [:create]
  alias Store.{Repo, User, UserRole, Term}

  def index(conn, _) do
    users = Repo.all(User)
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


  def upload_examinees(conn, %{"examinees" => examinees_params}) do
    for examinee_params <- examinees_params do
      user_params = %{
        first_name: examinee_params["first_name"],
        last_name: examinee_params["last_name"],
        email: examinee_params["registration_no"] <> "@postutme.edu.ng",
        password: examinee_params["jamb_registration_no"]
      }

      changeset = User.changeset(%User{}, user_params)
      {:ok, user} = Repo.insert(changeset)

      role = Term
      |> Term.fetch("role","Examinee")
      |> Repo.all
      |> List.first

      user_role_params = %{user_id: user.id, role_id: role.id, default: true}
      changeset = UserRole.changeset(%UserRole{}, user_role_params)
      {:ok, user_role} = Repo.insert(changeset)
    end

    conn
    |> render("examinee_uploaded.json")

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


end
