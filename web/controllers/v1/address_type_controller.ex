defmodule Store.V1.AddressTypeController do
  use Store.Web, :controller

  alias Store.AddressType

  plug :scrub_params, "address_type" when action in [:create, :update]

  def index(conn, _params) do
    address_types = Repo.all(AddressType)
    render(conn, "index.json", address_types: address_types)
  end

  def create(conn, %{"address_type" => address_type_params}) do
    changeset = AddressType.changeset(%AddressType{}, address_type_params)

    case Repo.insert(changeset) do
      {:ok, address_type} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_address_type_path(conn, :show, address_type))
        |> render("show.json", address_type: address_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    address_type = Repo.get!(AddressType, id)
    render(conn, "show.json", address_type: address_type)
  end

  def update(conn, %{"id" => id, "address_type" => address_type_params}) do
    address_type = Repo.get!(AddressType, id)
    changeset = AddressType.changeset(address_type, address_type_params)

    case Repo.update(changeset) do
      {:ok, address_type} ->
        render(conn, "show.json", address_type: address_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    address_type = Repo.get!(AddressType, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(address_type)

    send_resp(conn, :no_content, "")
  end
end
