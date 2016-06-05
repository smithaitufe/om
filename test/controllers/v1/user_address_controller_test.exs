defmodule Store.V1.UserAddressControllerTest do
  use Store.ConnCase

  alias Store.V1.UserAddress
  @valid_attrs %{active: true, default: true}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_address_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_address = Repo.insert! %UserAddress{}
    conn = get conn, user_address_path(conn, :show, user_address)
    assert json_response(conn, 200)["data"] == %{"id" => user_address.id,
      "user_id" => user_address.user_id,
      "address_id" => user_address.address_id,
      "address_type_id" => user_address.address_type_id,
      "default" => user_address.default,
      "active" => user_address.active}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, user_address_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_address_path(conn, :create), user_address: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserAddress, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_address_path(conn, :create), user_address: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_address = Repo.insert! %UserAddress{}
    conn = put conn, user_address_path(conn, :update, user_address), user_address: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(UserAddress, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_address = Repo.insert! %UserAddress{}
    conn = put conn, user_address_path(conn, :update, user_address), user_address: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_address = Repo.insert! %UserAddress{}
    conn = delete conn, user_address_path(conn, :delete, user_address)
    assert response(conn, 204)
    refute Repo.get(UserAddress, user_address.id)
  end
end
