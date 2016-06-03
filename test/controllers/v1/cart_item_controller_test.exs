defmodule Store.V1.CartItemControllerTest do
  use Store.ConnCase

  alias Store.V1.CartItem
  @valid_attrs %{active: true, iactive: true, quantity: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, cart_item_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    cart_item = Repo.insert! %CartItem{}
    conn = get conn, cart_item_path(conn, :show, cart_item)
    assert json_response(conn, 200)["data"] == %{"id" => cart_item.id,
      "cart_id" => cart_item.cart_id,
      "variant_id" => cart_item.variant_id,
      "quantity" => cart_item.quantity,
      "active" => cart_item.active,
      "iactive" => cart_item.iactive,
      "item_type_id" => cart_item.item_type_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, cart_item_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, cart_item_path(conn, :create), cart_item: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(CartItem, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, cart_item_path(conn, :create), cart_item: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    cart_item = Repo.insert! %CartItem{}
    conn = put conn, cart_item_path(conn, :update, cart_item), cart_item: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(CartItem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cart_item = Repo.insert! %CartItem{}
    conn = put conn, cart_item_path(conn, :update, cart_item), cart_item: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    cart_item = Repo.insert! %CartItem{}
    conn = delete conn, cart_item_path(conn, :delete, cart_item)
    assert response(conn, 204)
    refute Repo.get(CartItem, cart_item.id)
  end
end
