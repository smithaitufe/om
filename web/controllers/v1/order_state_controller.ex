defmodule Store.V1.OrderStateController do
  use Store.Web, :controller

  alias Store.OrderState

  plug :scrub_params, "order_state" when action in [:create, :update]

  def index(conn, _params) do
    order_statees = Repo.all(OrderState)
    render(conn, "index.json", order_statees: order_statees)
  end

  def create(conn, %{"order_state" => order_state_params}) do
    changeset = OrderState.changeset(%OrderState{}, order_state_params)

    case Repo.insert(changeset) do
      {:ok, order_state} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_order_state_path(conn, :show, order_state))
        |> render("show.json", order_state: order_state)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    order_state = Repo.get!(OrderState, id)
    render(conn, "show.json", order_state: order_state)
  end

  def update(conn, %{"id" => id, "order_state" => order_state_params}) do
    order_state = Repo.get!(OrderState, id)
    changeset = OrderState.changeset(order_state, order_state_params)

    case Repo.update(changeset) do
      {:ok, order_state} ->
        render(conn, "show.json", order_state: order_state)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    order_state = Repo.get!(OrderState, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(order_state)

    send_resp(conn, :no_content, "")
  end
end
