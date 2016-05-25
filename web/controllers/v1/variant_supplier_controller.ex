defmodule Store.V1.VariantSupplierController do
  use Store.Web, :controller

  alias Store.VariantSupplier

  plug :scrub_params, "variant_supplier" when action in [:create, :update]

  def index(conn, _params) do
    variant_suppliers = Repo.all(VariantSupplier)
    render(conn, "index.json", variant_suppliers: variant_suppliers)
  end

  def create(conn, %{"variant_supplier" => variant_supplier_params}) do
    changeset = VariantSupplier.changeset(%VariantSupplier{}, variant_supplier_params)

    case Repo.insert(changeset) do
      {:ok, variant_supplier} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_variant_supplier_path(conn, :show, variant_supplier))
        |> render("show.json", variant_supplier: variant_supplier)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    variant_supplier = Repo.get!(VariantSupplier, id)
    render(conn, "show.json", variant_supplier: variant_supplier)
  end

  def update(conn, %{"id" => id, "variant_supplier" => variant_supplier_params}) do
    variant_supplier = Repo.get!(VariantSupplier, id)
    changeset = VariantSupplier.changeset(variant_supplier, variant_supplier_params)

    case Repo.update(changeset) do
      {:ok, variant_supplier} ->
        render(conn, "show.json", variant_supplier: variant_supplier)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    variant_supplier = Repo.get!(VariantSupplier, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(variant_supplier)

    send_resp(conn, :no_content, "")
  end
end
