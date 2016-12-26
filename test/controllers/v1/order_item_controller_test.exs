defmodule Store.V1.OrderItemControllerTest do
  use Store.ConnCase

  alias Store.V1.OrderItem
  @valid_attrs %{price: "120.5", quantity: 42, state: "some content", total: "120.5"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, order_item_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    order_item = Repo.insert! %OrderItem{}
    conn = get conn, order_item_path(conn, :show, order_item)
    assert json_response(conn, 200)["data"] == %{"id" => order_item.id,
      "order_id" => order_item.order_id,
      "variant_id" => order_item.variant_id,
      "price" => order_item.price,
      "quantity" => order_item.quantity,
      "total" => order_item.total,
      "state" => order_item.state}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, order_item_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, order_item_path(conn, :create), order_item: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(OrderItem, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, order_item_path(conn, :create), order_item: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    order_item = Repo.insert! %OrderItem{}
    conn = put conn, order_item_path(conn, :update, order_item), order_item: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(OrderItem, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    order_item = Repo.insert! %OrderItem{}
    conn = put conn, order_item_path(conn, :update, order_item), order_item: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    order_item = Repo.insert! %OrderItem{}
    conn = delete conn, order_item_path(conn, :delete, order_item)
    assert response(conn, 204)
    refute Repo.get(OrderItem, order_item.id)
  end
end
