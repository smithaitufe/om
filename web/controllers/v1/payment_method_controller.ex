defmodule Store.V1.PaymentMethodController do
  use Store.Web, :controller

  alias Store.PaymentMethod

  plug :scrub_params, "payment_method" when action in [:create, :update]

  def index(conn, _params) do
    payment_methods = Repo.all(PaymentMethod)
    render(conn, "index.json", payment_methods: payment_methods)
  end

  def create(conn, %{"payment_method" => payment_method_params}) do
    changeset = PaymentMethod.changeset(%PaymentMethod{}, payment_method_params)

    case Repo.insert(changeset) do
      {:ok, payment_method} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_payment_method_path(conn, :show, payment_method))
        |> render("show.json", payment_method: payment_method)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    payment_method = Repo.get!(PaymentMethod, id)
    render(conn, "show.json", payment_method: payment_method)
  end

  def update(conn, %{"id" => id, "payment_method" => payment_method_params}) do
    payment_method = Repo.get!(PaymentMethod, id)
    changeset = PaymentMethod.changeset(payment_method, payment_method_params)

    case Repo.update(changeset) do
      {:ok, payment_method} ->
        render(conn, "show.json", payment_method: payment_method)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    payment_method = Repo.get!(PaymentMethod, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(payment_method)

    send_resp(conn, :no_content, "")
  end
end
