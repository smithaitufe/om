defmodule Store.V1.ProductConditionController do
  use Store.Web, :controller

  alias Store.ProductCondition

  def index(conn, _params) do
    product_conditions = Repo.all(ProductCondition)
    render(conn, "index.json", product_conditions: product_conditions)
  end

  def create(conn, %{"product_condition" => product_condition_params}) do
    changeset = ProductCondition.changeset(%ProductCondition{}, product_condition_params)

    case Repo.insert(changeset) do
      {:ok, product_condition} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_product_condition_path(conn, :show, product_condition))
        |> render("show.json", product_condition: product_condition)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product_condition = Repo.get!(ProductCondition, id)
    render(conn, "show.json", product_condition: product_condition)
  end

  def update(conn, %{"id" => id, "product_condition" => product_condition_params}) do
    product_condition = Repo.get!(ProductCondition, id)
    changeset = ProductCondition.changeset(product_condition, product_condition_params)

    case Repo.update(changeset) do
      {:ok, product_condition} ->
        render(conn, "show.json", product_condition: product_condition)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product_condition = Repo.get!(ProductCondition, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(product_condition)

    send_resp(conn, :no_content, "")
  end
end
