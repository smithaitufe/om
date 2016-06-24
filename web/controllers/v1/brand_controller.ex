defmodule Store.V1.BrandController do
  use Store.Web, :controller

  alias Store.Brand

  plug :scrub_params, "brand" when action in [:create, :update]

  def index(conn, _params) do
    brands = Repo.all(Brand)
    render(conn, "index.json", brands: brands)
  end

  def create(conn, %{"brand" => brand_params}) do
    changeset = Brand.changeset(%Brand{}, brand_params)

    case Repo.insert(changeset) do
      {:ok, brand} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_brand_path(conn, :show, brand))
        |> render("show.json", brand: brand)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    brand = Repo.get!(Brand, id)
    render(conn, "show.json", brand: brand)
  end

  def update(conn, %{"id" => id, "brand" => brand_params}) do
    brand = Repo.get!(Brand, id)
    changeset = Brand.changeset(brand, brand_params)

    case Repo.update(changeset) do
      {:ok, brand} ->
        render(conn, "show.json", brand: brand)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    brand = Repo.get!(Brand, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(brand)

    send_resp(conn, :no_content, "")
  end
end
