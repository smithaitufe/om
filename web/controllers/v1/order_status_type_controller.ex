defmodule Store.V1.OrderStatusTypeController do
  use Store.Web, :controller

  alias Store.OrderStatusType

  plug :scrub_params, "order_status_type" when action in [:create, :update]

  def index(conn, _params) do
    order_status_types = Repo.all(OrderStatusType)
    render(conn, "index.json", order_status_types: order_status_types)
  end

  def create(conn, %{"order_status_type" => order_status_type_params}) do
    changeset = OrderStatusType.changeset(%OrderStatusType{}, order_status_type_params)

    case Repo.insert(changeset) do
      {:ok, order_status_type} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_order_status_type_path(conn, :show, order_status_type))
        |> render("show.json", order_status_type: order_status_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order_status_type = Repo.get!(OrderStatusType, id)
    render(conn, "show.json", order_status_type: order_status_type)
  end

  def update(conn, %{"id" => id, "order_status_type" => order_status_type_params}) do
    order_status_type = Repo.get!(OrderStatusType, id)
    changeset = OrderStatusType.changeset(order_status_type, order_status_type_params)

    case Repo.update(changeset) do
      {:ok, order_status_type} ->
        render(conn, "show.json", order_status_type: order_status_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_status_type = Repo.get!(OrderStatusType, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(order_status_type)

    send_resp(conn, :no_content, "")
  end
end
