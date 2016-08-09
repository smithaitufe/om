defmodule Store.V1.ProductTagController do
  use Store.Web, :controller

  alias Store.ProductTag

  plug :scrub_params, "product_tag" when action in [:create, :update]

  def index(conn, _params) do
    product_tags = Repo.all(ProductTag)
    render(conn, "index.json", product_tags: product_tags)
  end

  def create(conn, %{"product_tag" => product_tag_params}) do
    changeset = ProductTag.changeset(%ProductTag{}, product_tag_params)

    case Repo.insert(changeset) do
      {:ok, product_tag} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_product_tag_path(conn, :show, product_tag))
        |> render("show.json", product_tag: product_tag)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product_tag = Repo.get!(ProductTag, id)
    render(conn, "show.json", product_tag: product_tag)
  end

  def update(conn, %{"id" => id, "product_tag" => product_tag_params}) do
    product_tag = Repo.get!(ProductTag, id)
    changeset = ProductTag.changeset(product_tag, product_tag_params)

    case Repo.update(changeset) do
      {:ok, product_tag} ->
        render(conn, "show.json", product_tag: product_tag)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product_tag = Repo.get!(ProductTag, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product_tag)

    send_resp(conn, :no_content, "")
  end
end
