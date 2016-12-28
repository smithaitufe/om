defmodule Store.V1.ShopUserController do
  use Store.Web, :controller

  alias Store.ShopUser

  plug :scrub_params, "shop_user" when action in [:create, :update]

  def index(conn, _params) do
    shop_users = Repo.all(ShopUser)
    render(conn, "index.json", shop_users: shop_users)
  end

  def create(conn, %{"shop_user" => shop_user_params}) do
    changeset = ShopUser.changeset(%ShopUser{}, shop_user_params)

    case Repo.insert(changeset) do
      {:ok, shop_user} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_shop_user_path(conn, :show, shop_user))
        |> render("show.json", shop_user: shop_user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shop_user = Repo.get!(ShopUser, id)
    render(conn, "show.json", shop_user: shop_user)
  end

  def update(conn, %{"id" => id, "shop_user" => shop_user_params}) do
    shop_user = Repo.get!(ShopUser, id)
    changeset = ShopUser.changeset(shop_user, shop_user_params)

    case Repo.update(changeset) do
      {:ok, shop_user} ->
        render(conn, "show.json", shop_user: shop_user)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    shop_user = Repo.get!(ShopUser, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(shop_user)

    send_resp(conn, :no_content, "")
  end
end
