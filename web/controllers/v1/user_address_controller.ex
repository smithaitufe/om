defmodule Store.V1.UserAddressController do
  use Store.Web, :controller

  alias Store.UserAddress

  plug :scrub_params, "user_address" when action in [:create, :update]

  def index(conn, _params) do
    user_addresses = Repo.all(UserAddress)
    render(conn, "index.json", user_addresses: user_addresses)
  end

  def create(conn, %{"user_address" => user_address_params}) do
    changeset = UserAddress.changeset(%UserAddress{}, user_address_params)

    case Repo.insert(changeset) do
      {:ok, user_address} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_user_address_path(conn, :show, user_address))
        |> render("show.json", user_address: user_address)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_address = Repo.get!(UserAddress, id)
    render(conn, "show.json", user_address: user_address)
  end

  def update(conn, %{"id" => id, "user_address" => user_address_params}) do
    user_address = Repo.get!(UserAddress, id)
    changeset = UserAddress.changeset(user_address, user_address_params)

    case Repo.update(changeset) do
      {:ok, user_address} ->
        render(conn, "show.json", user_address: user_address)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_address = Repo.get!(UserAddress, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_address)

    send_resp(conn, :no_content, "")
  end
end
