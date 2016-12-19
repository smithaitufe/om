defmodule Store.V1.UserTypeControllerTest do
  use Store.ConnCase

  alias Store.V1.UserType
  @valid_attrs %{code: "some content", description: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, user_type_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_type = Repo.insert! %UserType{}
    conn = get conn, user_type_path(conn, :show, user_type)
    assert json_response(conn, 200)["data"] == %{"id" => user_type.id,
      "name" => user_type.name,
      "description" => user_type.description,
      "code" => user_type.code}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, user_type_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, user_type_path(conn, :create), user_type: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserType, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, user_type_path(conn, :create), user_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_type = Repo.insert! %UserType{}
    conn = put conn, user_type_path(conn, :update, user_type), user_type: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(UserType, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_type = Repo.insert! %UserType{}
    conn = put conn, user_type_path(conn, :update, user_type), user_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_type = Repo.insert! %UserType{}
    conn = delete conn, user_type_path(conn, :delete, user_type)
    assert response(conn, 204)
    refute Repo.get(UserType, user_type.id)
  end
end
