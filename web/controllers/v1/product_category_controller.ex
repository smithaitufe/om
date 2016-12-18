defmodule Store.V1.ProductCategoryController do
  use Store.Web, :controller

  alias Store.ProductCategory

  plug :scrub_params, "product_category" when action in [:create, :update]

  def index(conn, _params) do
    product_categories = Repo.all(ProductCategory)
    render(conn, "index.json", product_categories: product_categories)
  end

  def create(conn, %{"product_category" => product_category_params}) do
    changeset = ProductCategory.changeset(%ProductCategory{}, product_category_params)

    case Repo.insert(changeset) do
      {:ok, product_category} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_product_category_path(conn, :show, product_category))
        |> render("show.json", product_category: product_category)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product_category = Repo.get!(ProductCategory, id)
    render(conn, "show.json", product_category: product_category)
  end

  def update(conn, %{"id" => id, "product_category" => product_category_params}) do
    product_category = Repo.get!(ProductCategory, id)
    changeset = ProductCategory.changeset(product_category, product_category_params)

    case Repo.update(changeset) do
      {:ok, product_category} ->
        render(conn, "show.json", product_category: product_category)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product_category = Repo.get!(ProductCategory, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product_category)

    send_resp(conn, :no_content, "")
  end
end
