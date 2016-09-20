defmodule Store.V1.CouponControllerTest do
  use Store.ConnCase

  alias Store.Coupon
  @valid_attrs %{amount: "120.5", code: "some content", combine: true, description: "some content", expires_at: "2010-04-17 14:00:00", minimum_value: "120.5", percent: 42, starts_at: "2010-04-17 14:00:00", type: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_coupon_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    coupon = Repo.insert! %Coupon{}
    conn = get conn, v1_coupon_path(conn, :show, coupon)
    assert json_response(conn, 200)["data"] == %{"id" => coupon.id,
      "type" => coupon.type,
      "code" => coupon.code,
      "description" => coupon.description,
      "amount" => coupon.amount,
      "minimum_value" => coupon.minimum_value,
      "percent" => coupon.percent,
      "combine" => coupon.combine,
      "starts_at" => coupon.starts_at,
      "expires_at" => coupon.expires_at}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_coupon_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_coupon_path(conn, :create), coupon: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Coupon, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_coupon_path(conn, :create), coupon: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    coupon = Repo.insert! %Coupon{}
    conn = put conn, v1_coupon_path(conn, :update, coupon), coupon: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Coupon, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    coupon = Repo.insert! %Coupon{}
    conn = put conn, v1_coupon_path(conn, :update, coupon), coupon: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    coupon = Repo.insert! %Coupon{}
    conn = delete conn, v1_coupon_path(conn, :delete, coupon)
    assert response(conn, 204)
    refute Repo.get(Coupon, coupon.id)
  end
end
