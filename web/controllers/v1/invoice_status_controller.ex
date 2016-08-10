defmodule Store.V1.InvoiceStatusController do
  use Store.Web, :controller

  alias Store.InvoiceStatus

  plug :scrub_params, "invoice_status" when action in [:create, :update]

  def index(conn, _params) do
    invoice_statuses = Repo.all(InvoiceStatus)
    render(conn, "index.json", invoice_statuses: invoice_statuses)
  end

  def create(conn, %{"invoice_status" => invoice_status_params}) do
    changeset = InvoiceStatus.changeset(%InvoiceStatus{}, invoice_status_params)

    case Repo.insert(changeset) do
      {:ok, invoice_status} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_invoice_status_path(conn, :show, invoice_status))
        |> render("show.json", invoice_status: invoice_status)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice_status = Repo.get!(InvoiceStatus, id)
    render(conn, "show.json", invoice_status: invoice_status)
  end

  def update(conn, %{"id" => id, "invoice_status" => invoice_status_params}) do
    invoice_status = Repo.get!(InvoiceStatus, id)
    changeset = InvoiceStatus.changeset(invoice_status, invoice_status_params)

    case Repo.update(changeset) do
      {:ok, invoice_status} ->
        render(conn, "show.json", invoice_status: invoice_status)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice_status = Repo.get!(InvoiceStatus, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(invoice_status)

    send_resp(conn, :no_content, "")
  end
end
