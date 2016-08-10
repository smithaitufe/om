defmodule Store.V1.OrderStatusController do
  use Store.Web, :controller

  alias Store.OrderStatus

  plug :scrub_params, "order_status" when action in [:create, :update]

  def index(conn, _params) do
    order_statuss = Repo.all(OrderStatus)
    render(conn, "index.json", order_statuss: order_statuss)
  end

  def create(conn, %{"order_status" => order_status_params}) do
    changeset = OrderStatus.changeset(%OrderStatus{}, order_status_params)

    case Repo.insert(changeset) do
      {:ok, order_status} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_order_status_path(conn, :show, order_status))
        |> render("show.json", order_status: order_status)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order_status = Repo.get!(OrderStatus, id)
    render(conn, "show.json", order_status: order_status)
  end

  def update(conn, %{"id" => id, "order_status" => order_status_params}) do
    order_status = Repo.get!(OrderStatus, id)
    changeset = OrderStatus.changeset(order_status, order_status_params)

    case Repo.update(changeset) do
      {:ok, order_status} ->
        render(conn, "show.json", order_status: order_status)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_status = Repo.get!(OrderStatus, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(order_status)

    send_resp(conn, :no_content, "")
  end
end
