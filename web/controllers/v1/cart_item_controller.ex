defmodule Store.V1.CartItemController do
  use Store.Web, :controller

  alias Store.CartItem

  plug :scrub_params, "cart_item" when action in [:create, :update]

  def index(conn, _params) do
    cart_items = Repo.all(CartItem)
    render(conn, "index.json", cart_items: cart_items)
  end

  def create(conn, %{"cart_item" => cart_item_params}) do
    changeset = CartItem.changeset(%CartItem{}, cart_item_params)

    case Repo.insert(changeset) do
      {:ok, cart_item} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_cart_item_path(conn, :show, cart_item))
        |> render("show.json", cart_item: cart_item)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cart_item = Repo.get!(CartItem, id)
    render(conn, "show.json", cart_item: cart_item)
  end

  def update(conn, %{"id" => id, "cart_item" => cart_item_params}) do
    cart_item = Repo.get!(CartItem, id)
    changeset = CartItem.changeset(cart_item, cart_item_params)

    case Repo.update(changeset) do
      {:ok, cart_item} ->
        render(conn, "show.json", cart_item: cart_item)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cart_item = Repo.get!(CartItem, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cart_item)

    send_resp(conn, :no_content, "")
  end
end
