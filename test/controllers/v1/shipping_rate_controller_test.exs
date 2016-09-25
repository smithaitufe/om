defmodule Store.V1.ShippingRateControllerTest do
  use Store.ConnCase

  alias Store.V1.ShippingRate
  @valid_attrs %{active: true, maximum: "120.5", minimum: "120.5", rate: "120.5"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, shipping_rate_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    shipping_rate = Repo.insert! %ShippingRate{}
    conn = get conn, shipping_rate_path(conn, :show, shipping_rate)
    assert json_response(conn, 200)["data"] == %{"id" => shipping_rate.id,
      "payment_method_id" => shipping_rate.payment_method_id,
      "shipping_method_id" => shipping_rate.shipping_method_id,
      "shipping_rate_type_id" => shipping_rate.shipping_rate_type_id,
      "minimum" => shipping_rate.minimum,
      "maximum" => shipping_rate.maximum,
      "rate" => shipping_rate.rate,
      "active" => shipping_rate.active}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, shipping_rate_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, shipping_rate_path(conn, :create), shipping_rate: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ShippingRate, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, shipping_rate_path(conn, :create), shipping_rate: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    shipping_rate = Repo.insert! %ShippingRate{}
    conn = put conn, shipping_rate_path(conn, :update, shipping_rate), shipping_rate: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ShippingRate, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    shipping_rate = Repo.insert! %ShippingRate{}
    conn = put conn, shipping_rate_path(conn, :update, shipping_rate), shipping_rate: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    shipping_rate = Repo.insert! %ShippingRate{}
    conn = delete conn, shipping_rate_path(conn, :delete, shipping_rate)
    assert response(conn, 204)
    refute Repo.get(ShippingRate, shipping_rate.id)
  end
end
