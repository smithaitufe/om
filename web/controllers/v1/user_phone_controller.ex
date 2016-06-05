defmodule Store.V1.UserPhoneController do
  use Store.Web, :controller

  alias Store.UserPhone

  plug :scrub_params, "user_phone" when action in [:create, :update]

  def index(conn, _params) do
    user_phones = Repo.all(UserPhone)
    render(conn, "index.json", user_phones: user_phones)
  end

  def create(conn, %{"user_phone" => user_phone_params}) do
    changeset = UserPhone.changeset(%UserPhone{}, user_phone_params)

    case Repo.insert(changeset) do
      {:ok, user_phone} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_user_phone_path(conn, :show, user_phone))
        |> render("show.json", user_phone: user_phone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_phone = Repo.get!(UserPhone, id)
    render(conn, "show.json", user_phone: user_phone)
  end

  def update(conn, %{"id" => id, "user_phone" => user_phone_params}) do
    user_phone = Repo.get!(UserPhone, id)
    changeset = UserPhone.changeset(user_phone, user_phone_params)

    case Repo.update(changeset) do
      {:ok, user_phone} ->
        render(conn, "show.json", user_phone: user_phone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_phone = Repo.get!(UserPhone, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_phone)

    send_resp(conn, :no_content, "")
  end
end
