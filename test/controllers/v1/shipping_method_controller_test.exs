defmodule Store.V1.ShippingMethodControllerTest do
  use Store.ConnCase

  alias Store.ShippingMethod
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_shipping_method_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    shipping_method = Repo.insert! %ShippingMethod{}
    conn = get conn, v1_shipping_method_path(conn, :show, shipping_method)
    assert json_response(conn, 200)["data"] == %{"id" => shipping_method.id,
      "name" => shipping_method.name,
      "shipping_zone_id" => shipping_method.shipping_zone_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_shipping_method_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_shipping_method_path(conn, :create), shipping_method: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ShippingMethod, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_shipping_method_path(conn, :create), shipping_method: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    shipping_method = Repo.insert! %ShippingMethod{}
    conn = put conn, v1_shipping_method_path(conn, :update, shipping_method), shipping_method: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ShippingMethod, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    shipping_method = Repo.insert! %ShippingMethod{}
    conn = put conn, v1_shipping_method_path(conn, :update, shipping_method), shipping_method: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    shipping_method = Repo.insert! %ShippingMethod{}
    conn = delete conn, v1_shipping_method_path(conn, :delete, shipping_method)
    assert response(conn, 204)
    refute Repo.get(ShippingMethod, shipping_method.id)
  end
end
