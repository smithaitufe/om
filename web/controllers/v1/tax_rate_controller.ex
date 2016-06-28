defmodule Store.V1.TaxRateController do
  use Store.Web, :controller

  alias Store.TaxRate

  plug :scrub_params, "tax_rate" when action in [:create, :update]

  def index(conn, _params) do
    tax_rates = Repo.all(TaxRate)
    render(conn, "index.json", tax_rates: tax_rates)
  end

  def create(conn, %{"tax_rate" => tax_rate_params}) do
    changeset = TaxRate.changeset(%TaxRate{}, tax_rate_params)

    case Repo.insert(changeset) do
      {:ok, tax_rate} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_tax_rate_path(conn, :show, tax_rate))
        |> render("show.json", tax_rate: tax_rate)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tax_rate = Repo.get!(TaxRate, id)
    render(conn, "show.json", tax_rate: tax_rate)
  end

  def update(conn, %{"id" => id, "tax_rate" => tax_rate_params}) do
    tax_rate = Repo.get!(TaxRate, id)
    changeset = TaxRate.changeset(tax_rate, tax_rate_params)

    case Repo.update(changeset) do
      {:ok, tax_rate} ->
        render(conn, "show.json", tax_rate: tax_rate)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tax_rate = Repo.get!(TaxRate, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tax_rate)

    send_resp(conn, :no_content, "")
  end
end
