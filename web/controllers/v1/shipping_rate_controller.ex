defmodule Store.V1.ShippingRateController do
  use     Store.Web, :controller
  alias   Store.ShippingRate

  plug :scrub_params, "shipping_rate" when action in [:create, :update]

  def index(conn, _params) do
    shipping_rates = Repo.all(ShippingRate)
    render(conn, "index.json", shipping_rates: shipping_rates)
  end

  def create(conn, %{"shipping_rate" => shipping_rate_params}) do
    changeset = ShippingRate.changeset(%ShippingRate{}, shipping_rate_params)

    case Repo.insert(changeset) do
      {:ok, shipping_rate} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_shipping_rate_path(conn, :show, shipping_rate))
        |> render("show.json", shipping_rate: shipping_rate)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shipping_rate = Repo.get!(ShippingRate, id)
    render(conn, "show.json", shipping_rate: shipping_rate)
  end

  def update(conn, %{"id" => id, "shipping_rate" => shipping_rate_params}) do
    shipping_rate = Repo.get!(ShippingRate, id)
    changeset = ShippingRate.changeset(shipping_rate, shipping_rate_params)

    case Repo.update(changeset) do
      {:ok, shipping_rate} ->
        render(conn, "show.json", shipping_rate: shipping_rate)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    shipping_rate = Repo.get!(ShippingRate, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(shipping_rate)

    send_resp(conn, :no_content, "")
  end
end
