defmodule Store.V1.ProductConditionControllerTest do
  use Store.ConnCase

  alias Store.V1.ProductCondition
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, product_condition_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    product_condition = Repo.insert! %ProductCondition{}
    conn = get conn, product_condition_path(conn, :show, product_condition)
    assert json_response(conn, 200)["data"] == %{"id" => product_condition.id,
      "name" => product_condition.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, product_condition_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, product_condition_path(conn, :create), product_condition: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ProductCondition, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, product_condition_path(conn, :create), product_condition: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    product_condition = Repo.insert! %ProductCondition{}
    conn = put conn, product_condition_path(conn, :update, product_condition), product_condition: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ProductCondition, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product_condition = Repo.insert! %ProductCondition{}
    conn = put conn, product_condition_path(conn, :update, product_condition), product_condition: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    product_condition = Repo.insert! %ProductCondition{}
    conn = delete conn, product_condition_path(conn, :delete, product_condition)
    assert response(conn, 204)
    refute Repo.get(ProductCondition, product_condition.id)
  end
end
