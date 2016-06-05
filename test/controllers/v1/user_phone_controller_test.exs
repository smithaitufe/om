defmodule Store.V1.UserPhoneControllerTest do
  use Store.ConnCase

  alias Store.V1.UserPhone
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_phone_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_phone = Repo.insert! %UserPhone{}
    conn = get conn, user_phone_path(conn, :show, user_phone)
    assert json_response(conn, 200)["data"] == %{"id" => user_phone.id,
      "phone_id" => user_phone.phone_id,
      "user_id" => user_phone.user_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, user_phone_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_phone_path(conn, :create), user_phone: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserPhone, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_phone_path(conn, :create), user_phone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_phone = Repo.insert! %UserPhone{}
    conn = put conn, user_phone_path(conn, :update, user_phone), user_phone: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(UserPhone, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_phone = Repo.insert! %UserPhone{}
    conn = put conn, user_phone_path(conn, :update, user_phone), user_phone: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_phone = Repo.insert! %UserPhone{}
    conn = delete conn, user_phone_path(conn, :delete, user_phone)
    assert response(conn, 204)
    refute Repo.get(UserPhone, user_phone.id)
  end
end
