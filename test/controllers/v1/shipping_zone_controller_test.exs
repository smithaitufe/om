defmodule Store.V1.ShippingZoneControllerTest do
  use Store.ConnCase

  alias Store.ShippingZone
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_shipping_zone_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    shipping_zone = Repo.insert! %ShippingZone{}
    conn = get conn, v1_shipping_zone_path(conn, :show, shipping_zone)
    assert json_response(conn, 200)["data"] == %{"id" => shipping_zone.id,
      "name" => shipping_zone.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_shipping_zone_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_shipping_zone_path(conn, :create), shipping_zone: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ShippingZone, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_shipping_zone_path(conn, :create), shipping_zone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    shipping_zone = Repo.insert! %ShippingZone{}
    conn = put conn, v1_shipping_zone_path(conn, :update, shipping_zone), shipping_zone: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ShippingZone, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    shipping_zone = Repo.insert! %ShippingZone{}
    conn = put conn, v1_shipping_zone_path(conn, :update, shipping_zone), shipping_zone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    shipping_zone = Repo.insert! %ShippingZone{}
    conn = delete conn, v1_shipping_zone_path(conn, :delete, shipping_zone)
    assert response(conn, 204)
    refute Repo.get(ShippingZone, shipping_zone.id)
  end
end
