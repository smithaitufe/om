defmodule Store.V1.ProductController do
  use Store.Web, :controller

  alias Store.Product

  plug :scrub_params, "product" when action in [:create, :update]

  def index(conn, params) do
    products = Product
    |> build_query(Map.to_list(params))
    |> Repo.all
    |> Repo.preload(Product.associations)

    render(conn, "index.json", products: products)
  end

  def create(conn, %{"product" => product_params}) do
    changeset = Product.changeset(%Product{}, product_params)

    case Repo.insert(changeset) do
      {:ok, product} ->
        product = product |> Repo.preload(Product.associations)

        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_product_path(conn, :show, product))
        |> render("show.json", product: product)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Product
    |> Repo.get(id)
    |> Repo.preload(Product.associations)

    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Repo.get!(Product, id)
    changeset = Product.changeset(product, product_params)

    case Repo.update(changeset) do
      {:ok, product} ->
        product= product |> Repo.preload(Product.associations)

        render(conn, "show.json", product: product)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Repo.get!(Product, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product)

    send_resp(conn, :no_content, "")
  end


  defp build_query(query, []) do
    query
  end
  defp build_query(query, [{"product_category_id", product_category_id} | tail ]) do
    query
    |> Ecto.Query.where([sc], sc.product_category_id == ^product_category_id)
    |> build_query(tail)
  end
  defp build_query(query, [{attr, val} | tail ]) do
    query
    |> Ecto.Query.where([sc], field(sc, ^String.to_existing_atom(attr)) == ^val)
    |> build_query(tail)
  end

end
