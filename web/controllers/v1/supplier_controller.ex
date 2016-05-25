defmodule Store.V1.SupplierController do
  use Store.Web, :controller

  alias Store.Supplier

  plug :scrub_params, "supplier" when action in [:create, :update]

  def index(conn, _params) do
    suppliers = Repo.all(Supplier)
    render(conn, "index.json", suppliers: suppliers)
  end

  def create(conn, %{"supplier" => supplier_params}) do
    changeset = Supplier.changeset(%Supplier{}, supplier_params)

    case Repo.insert(changeset) do
      {:ok, supplier} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_supplier_path(conn, :show, supplier))
        |> render("show.json", supplier: supplier)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    supplier = Repo.get!(Supplier, id)
    render(conn, "show.json", supplier: supplier)
  end

  def update(conn, %{"id" => id, "supplier" => supplier_params}) do
    supplier = Repo.get!(Supplier, id)
    changeset = Supplier.changeset(supplier, supplier_params)

    case Repo.update(changeset) do
      {:ok, supplier} ->
        render(conn, "show.json", supplier: supplier)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    supplier = Repo.get!(Supplier, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(supplier)

    send_resp(conn, :no_content, "")
  end
end
