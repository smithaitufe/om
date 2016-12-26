defmodule Store.V1.OrderItemController do
  use Store.Web, :controller

  alias Store.OrderItem

  plug :scrub_params, "order_item" when action in [:create, :update]

  def index(conn, _params) do
    order_items = Repo.all(OrderItem)
    render(conn, "index.json", order_items: order_items)
  end

  def create(conn, %{"order_item" => order_item_params}) do
    changeset = OrderItem.changeset(%OrderItem{}, order_item_params)

    case Repo.insert(changeset) do
      {:ok, order_item} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_order_item_path(conn, :show, order_item))
        |> render("show.json", order_item: order_item)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order_item = Repo.get!(OrderItem, id)
    render(conn, "show.json", order_item: order_item)
  end

  def update(conn, %{"id" => id, "order_item" => order_item_params}) do
    order_item = Repo.get!(OrderItem, id)
    changeset = OrderItem.changeset(order_item, order_item_params)

    case Repo.update(changeset) do
      {:ok, order_item} ->
        render(conn, "show.json", order_item: order_item)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_item = Repo.get!(OrderItem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(order_item)

    send_resp(conn, :no_content, "")
  end
end
