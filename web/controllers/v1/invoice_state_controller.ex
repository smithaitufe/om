defmodule Store.V1.InvoiceStateController do
  use Store.Web, :controller

  alias Store.InvoiceState

  plug :scrub_params, "invoice_state" when action in [:create, :update]

  def index(conn, _params) do
    invoice_states = Repo.all(InvoiceState)
    render(conn, "index.json", invoice_states: invoice_states)
  end

  def create(conn, %{"invoice_state" => invoice_state_params}) do
    changeset = InvoiceState.changeset(%InvoiceState{}, invoice_state_params)

    case Repo.insert(changeset) do
      {:ok, invoice_state} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_invoice_state_path(conn, :show, invoice_state))
        |> render("show.json", invoice_state: invoice_state)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    invoice_state = Repo.get!(InvoiceState, id)
    render(conn, "show.json", invoice_state: invoice_state)
  end

  def update(conn, %{"id" => id, "invoice_state" => invoice_state_params}) do
    invoice_state = Repo.get!(InvoiceState, id)
    changeset = InvoiceState.changeset(invoice_state, invoice_state_params)

    case Repo.update(changeset) do
      {:ok, invoice_state} ->
        render(conn, "show.json", invoice_state: invoice_state)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    invoice_state = Repo.get!(InvoiceState, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(invoice_state)

    send_resp(conn, :no_content, "")
  end
end
