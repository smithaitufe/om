defmodule Store.V1.CartController do
  use Store.Web, :controller

  alias Store.Cart

  plug :scrub_params, "cart" when action in [:create, :update]

  def index(conn, params) do
    carts = Cart
    |> build_query(Map.to_list(params))
    |> Repo.all
    |> Repo.preload(Cart.associations)

    render(conn, "index.json", carts: carts)
  end

  def create(conn, %{"cart" => cart_params}) do
    changeset = Cart.changeset(%Cart{}, cart_params)

    case Repo.insert(changeset) do
      {:ok, cart} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_cart_path(conn, :show, cart))
        |> render("show.json", cart: cart)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    cart = Repo.get!(Cart, id)
    render(conn, "show.json", cart: cart)
  end

  def update(conn, %{"id" => id, "cart" => cart_params}) do
    cart = Repo.get!(Cart, id)
    changeset = Cart.changeset(cart, cart_params)

    case Repo.update(changeset) do
      {:ok, cart} ->
        render(conn, "show.json", cart: cart)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    cart = Repo.get!(Cart, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(cart)

    send_resp(conn, :no_content, "")
  end

  defp build_query(query, []), do: query    
  # defp filter_where(params) do
  #   keys = Map.to_list(params) |> Keyword.keys
  #   for key <- keys, value = params[Atom.to_string(params)], do: {key, value}
  # end
  defp build_query(query, [{"order_by", value} | tail]) do
    query
    |> Ecto.Query.order_by([query], [asc: ^String.to_atom(value)])
    |> build_query(tail)
  end
  defp build_query(query, [{attr, value} | tail ]) do
    query
    |> Ecto.Query.where([query], fragment("? = ?", ^attr, ^value))
    |> build_query(tail)
    
  end
end
