defmodule Store.V1.PrototypeControllerTest do
  use Store.ConnCase

  alias Store.Prototype
  @valid_attrs %{active: true, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_prototype_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    prototype = Repo.insert! %Prototype{}
    conn = get conn, v1_prototype_path(conn, :show, prototype)
    assert json_response(conn, 200)["data"] == %{"id" => prototype.id,
      "name" => prototype.name,
      "active" => prototype.active}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_prototype_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_prototype_path(conn, :create), prototype: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Prototype, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_prototype_path(conn, :create), prototype: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    prototype = Repo.insert! %Prototype{}
    conn = put conn, v1_prototype_path(conn, :update, prototype), prototype: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Prototype, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    prototype = Repo.insert! %Prototype{}
    conn = put conn, v1_prototype_path(conn, :update, prototype), prototype: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    prototype = Repo.insert! %Prototype{}
    conn = delete conn, v1_prototype_path(conn, :delete, prototype)
    assert response(conn, 204)
    refute Repo.get(Prototype, prototype.id)
  end
end
