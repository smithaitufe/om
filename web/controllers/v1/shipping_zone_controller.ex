defmodule Store.V1.ShippingZoneController do
  use Store.Web, :controller

  alias Store.ShippingZone

  plug :scrub_params, "shipping_zone" when action in [:create, :update]

  def index(conn, _params) do
    shipping_zones = Repo.all(ShippingZone)
    render(conn, "index.json", shipping_zones: shipping_zones)
  end

  def create(conn, %{"shipping_zone" => shipping_zone_params}) do
    changeset = ShippingZone.changeset(%ShippingZone{}, shipping_zone_params)

    case Repo.insert(changeset) do
      {:ok, shipping_zone} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_shipping_zone_path(conn, :show, shipping_zone))
        |> render("show.json", shipping_zone: shipping_zone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shipping_zone = Repo.get!(ShippingZone, id)
    render(conn, "show.json", shipping_zone: shipping_zone)
  end

  def update(conn, %{"id" => id, "shipping_zone" => shipping_zone_params}) do
    shipping_zone = Repo.get!(ShippingZone, id)
    changeset = ShippingZone.changeset(shipping_zone, shipping_zone_params)

    case Repo.update(changeset) do
      {:ok, shipping_zone} ->
        render(conn, "show.json", shipping_zone: shipping_zone)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    shipping_zone = Repo.get!(ShippingZone, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(shipping_zone)

    send_resp(conn, :no_content, "")
  end
end
