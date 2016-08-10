defmodule Store.V1.OrderStateControllerTest do
  use Store.ConnCase

  alias Store.V1.OrderState
  @valid_attrs %{active: true}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, order_state_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    order_state = Repo.insert! %OrderState{}
    conn = get conn, order_state_path(conn, :show, order_state)
    assert json_response(conn, 200)["data"] == %{"id" => order_state.id,
      "order_id" => order_state.order_id,
      "order_state_type_id" => order_state.order_state_type_id,
      "active" => order_state.active}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, order_state_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, order_state_path(conn, :create), order_state: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(OrderState, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, order_state_path(conn, :create), order_state: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    order_state = Repo.insert! %OrderState{}
    conn = put conn, order_state_path(conn, :update, order_state), order_state: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(OrderState, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    order_state = Repo.insert! %OrderState{}
    conn = put conn, order_state_path(conn, :update, order_state), order_state: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    order_state = Repo.insert! %OrderState{}
    conn = delete conn, order_state_path(conn, :delete, order_state)
    assert response(conn, 204)
    refute Repo.get(OrderState, order_state.id)
  end
end
