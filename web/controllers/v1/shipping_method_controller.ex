defmodule Store.V1.ShippingMethodController do
  use Store.Web, :controller

  alias Store.ShippingMethod

  plug :scrub_params, "shipping_method" when action in [:create, :update]

  def index(conn, _params) do
    shipping_methods = Repo.all(ShippingMethod)
    render(conn, "index.json", shipping_methods: shipping_methods)
  end

  def create(conn, %{"shipping_method" => shipping_method_params}) do
    changeset = ShippingMethod.changeset(%ShippingMethod{}, shipping_method_params)

    case Repo.insert(changeset) do
      {:ok, shipping_method} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_shipping_method_path(conn, :show, shipping_method))
        |> render("show.json", shipping_method: shipping_method)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shipping_method = Repo.get!(ShippingMethod, id)
    render(conn, "show.json", shipping_method: shipping_method)
  end

  def update(conn, %{"id" => id, "shipping_method" => shipping_method_params}) do
    shipping_method = Repo.get!(ShippingMethod, id)
    changeset = ShippingMethod.changeset(shipping_method, shipping_method_params)

    case Repo.update(changeset) do
      {:ok, shipping_method} ->
        render(conn, "show.json", shipping_method: shipping_method)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    shipping_method = Repo.get!(ShippingMethod, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(shipping_method)

    send_resp(conn, :no_content, "")
  end
end
