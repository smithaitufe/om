defmodule Store.V1.ProductPropertyController do
  use Store.Web, :controller

  alias Store.ProductProperty

  plug :scrub_params, "product_property" when action in [:create, :update]

  def index(conn, _params) do
    product_properties = Repo.all(ProductProperty)
    render(conn, "index.json", product_properties: product_properties)
  end

  def create(conn, %{"product_property" => product_property_params}) do
    changeset = ProductProperty.changeset(%ProductProperty{}, product_property_params)

    case Repo.insert(changeset) do
      {:ok, product_property} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_product_property_path(conn, :show, product_property))
        |> render("show.json", product_property: product_property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product_property = Repo.get!(ProductProperty, id)
    render(conn, "show.json", product_property: product_property)
  end

  def update(conn, %{"id" => id, "product_property" => product_property_params}) do
    product_property = Repo.get!(ProductProperty, id)
    changeset = ProductProperty.changeset(product_property, product_property_params)

    case Repo.update(changeset) do
      {:ok, product_property} ->
        render(conn, "show.json", product_property: product_property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product_property = Repo.get!(ProductProperty, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product_property)

    send_resp(conn, :no_content, "")
  end
end
