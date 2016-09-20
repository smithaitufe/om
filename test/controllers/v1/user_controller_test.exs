defmodule Store.V1.UserControllerTest do
  use Store.ConnCase

  alias Store.User
  @valid_attrs %{active: true, email: "some content", encrypted_password: "some content", first_name: "some content", last_name: "some content", lock_expires_at: "2010-04-17 14:00:00", locked: true, login_attempts: 42, reset_token: "some content", reset_token_created_at: "2010-04-17 14:00:00", reset_token_expires_at: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_user_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = get conn, v1_user_path(conn, :show, user)
    assert json_response(conn, 200)["data"] == %{"id" => user.id,
      "last_name" => user.last_name,
      "first_name" => user.first_name,
      "email" => user.email,
      "encrypted_password" => user.encrypted_password,
      "active" => user.active,
      "locked" => user.locked,
      "lock_expires_at" => user.lock_expires_at,
      "reset_token" => user.reset_token,
      "reset_token_created_at" => user.reset_token_created_at,
      "reset_token_expires_at" => user.reset_token_expires_at,
      "login_attempts" => user.login_attempts}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_user_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_user_path(conn, :create), user: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_user_path(conn, :create), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, v1_user_path(conn, :update, user), user: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(User, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = put conn, v1_user_path(conn, :update, user), user: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user = Repo.insert! %User{}
    conn = delete conn, v1_user_path(conn, :delete, user)
    assert response(conn, 204)
    refute Repo.get(User, user.id)
  end
end
