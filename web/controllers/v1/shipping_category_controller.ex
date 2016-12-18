defmodule Store.V1.ShippingCategoryController do
  use Store.Web, :controller

  alias Store.ShippingCategory

  plug :scrub_params, "shipping_category" when action in [:create, :update]

  def index(conn, _params) do
    shipping_categories = Repo.all(ShippingCategory)
    render(conn, "index.json", shipping_categories: shipping_categories)
  end

  def create(conn, %{"shipping_category" => shipping_category_params}) do
    changeset = ShippingCategory.changeset(%ShippingCategory{}, shipping_category_params)

    case Repo.insert(changeset) do
      {:ok, shipping_category} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_shipping_category_path(conn, :show, shipping_category))
        |> render("show.json", shipping_category: shipping_category)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    shipping_category = Repo.get!(ShippingCategory, id)
    render(conn, "show.json", shipping_category: shipping_category)
  end

  def update(conn, %{"id" => id, "shipping_category" => shipping_category_params}) do
    shipping_category = Repo.get!(ShippingCategory, id)
    changeset = ShippingCategory.changeset(shipping_category, shipping_category_params)

    case Repo.update(changeset) do
      {:ok, shipping_category} ->
        render(conn, "show.json", shipping_category: shipping_category)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    shipping_category = Repo.get!(ShippingCategory, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(shipping_category)

    send_resp(conn, :no_content, "")
  end
end
