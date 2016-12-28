defmodule Store.V1.ShopUserControllerTest do
  use Store.ConnCase

  alias Store.V1.ShopUser
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, shop_user_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    shop_user = Repo.insert! %ShopUser{}
    conn = get conn, shop_user_path(conn, :show, shop_user)
    assert json_response(conn, 200)["data"] == %{"id" => shop_user.id,
      "shop_id" => shop_user.shop_id,
      "user_id" => shop_user.user_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, shop_user_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, shop_user_path(conn, :create), shop_user: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ShopUser, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, shop_user_path(conn, :create), shop_user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    shop_user = Repo.insert! %ShopUser{}
    conn = put conn, shop_user_path(conn, :update, shop_user), shop_user: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ShopUser, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    shop_user = Repo.insert! %ShopUser{}
    conn = put conn, shop_user_path(conn, :update, shop_user), shop_user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    shop_user = Repo.insert! %ShopUser{}
    conn = delete conn, shop_user_path(conn, :delete, shop_user)
    assert response(conn, 204)
    refute Repo.get(ShopUser, shop_user.id)
  end
end
