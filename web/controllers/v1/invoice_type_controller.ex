defmodule Store.V1.InvoiceTypeController do
  use Store.Web, :controller

  alias Store.InvoiceType

  plug :scrub_params, "invoice_type" when action in [:create, :update]

  def index(conn, _params) do
    invoice_types = Repo.all(InvoiceType)
    render(conn, "index.json", invoice_types: invoice_types)
  end

  def create(conn, %{"invoice_type" => invoice_type_params}) do
    changeset = InvoiceType.changeset(%InvoiceType{}, invoice_type_params)

    case Repo.insert(changeset) do
      {:ok, invoice_type} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_invoice_type_path(conn, :show, invoice_type))
        |> render("show.json", invoice_type: invoice_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice_type = Repo.get!(InvoiceType, id)
    render(conn, "show.json", invoice_type: invoice_type)
  end

  def update(conn, %{"id" => id, "invoice_type" => invoice_type_params}) do
    invoice_type = Repo.get!(InvoiceType, id)
    changeset = InvoiceType.changeset(invoice_type, invoice_type_params)

    case Repo.update(changeset) do
      {:ok, invoice_type} ->
        render(conn, "show.json", invoice_type: invoice_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice_type = Repo.get!(InvoiceType, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(invoice_type)

    send_resp(conn, :no_content, "")
  end
end
