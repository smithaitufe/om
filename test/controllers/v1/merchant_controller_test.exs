defmodule Store.V1.MerchantControllerTest do
  use Store.ConnCase

  alias Store.V1.Merchant
  @valid_attrs %{email: "some content", name: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, merchant_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    merchant = Repo.insert! %Merchant{}
    conn = get conn, merchant_path(conn, :show, merchant)
    assert json_response(conn, 200)["data"] == %{"id" => merchant.id,
      "name" => merchant.name,
      "phone_number" => merchant.phone_number,
      "email" => merchant.email}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, merchant_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, merchant_path(conn, :create), merchant: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Merchant, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, merchant_path(conn, :create), merchant: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    merchant = Repo.insert! %Merchant{}
    conn = put conn, merchant_path(conn, :update, merchant), merchant: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Merchant, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    merchant = Repo.insert! %Merchant{}
    conn = put conn, merchant_path(conn, :update, merchant), merchant: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    merchant = Repo.insert! %Merchant{}
    conn = delete conn, merchant_path(conn, :delete, merchant)
    assert response(conn, 204)
    refute Repo.get(Merchant, merchant.id)
  end
end
