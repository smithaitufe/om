defmodule Store.V1.OrderStatusTypeControllerTest do
  use Store.ConnCase

  alias Store.V1.OrderStatusType
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, order_status_type_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    order_status_type = Repo.insert! %OrderStatusType{}
    conn = get conn, order_status_type_path(conn, :show, order_status_type)
    assert json_response(conn, 200)["data"] == %{"id" => order_status_type.id,
      "name" => order_status_type.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, order_status_type_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, order_status_type_path(conn, :create), order_status_type: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(OrderStatusType, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, order_status_type_path(conn, :create), order_status_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    order_status_type = Repo.insert! %OrderStatusType{}
    conn = put conn, order_status_type_path(conn, :update, order_status_type), order_status_type: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(OrderStatusType, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    order_status_type = Repo.insert! %OrderStatusType{}
    conn = put conn, order_status_type_path(conn, :update, order_status_type), order_status_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    order_status_type = Repo.insert! %OrderStatusType{}
    conn = delete conn, order_status_type_path(conn, :delete, order_status_type)
    assert response(conn, 204)
    refute Repo.get(OrderStatusType, order_status_type.id)
  end
end
