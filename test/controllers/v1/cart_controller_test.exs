defmodule Store.V1.CartControllerTest do
  use Store.ConnCase

  alias Store.Cart
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_cart_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    cart = Repo.insert! %Cart{}
    conn = get conn, v1_cart_path(conn, :show, cart)
    assert json_response(conn, 200)["data"] == %{"id" => cart.id,
      "user_id" => cart.user_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_cart_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_cart_path(conn, :create), cart: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Cart, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_cart_path(conn, :create), cart: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    cart = Repo.insert! %Cart{}
    conn = put conn, v1_cart_path(conn, :update, cart), cart: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Cart, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    cart = Repo.insert! %Cart{}
    conn = put conn, v1_cart_path(conn, :update, cart), cart: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    cart = Repo.insert! %Cart{}
    conn = delete conn, v1_cart_path(conn, :delete, cart)
    assert response(conn, 204)
    refute Repo.get(Cart, cart.id)
  end
end
