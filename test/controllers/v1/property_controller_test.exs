defmodule Store.V1.PropertyControllerTest do
  use Store.ConnCase

  alias Store.V1.Property
  @valid_attrs %{active: true, display_name: "some content", identifying_name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, property_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = get conn, property_path(conn, :show, property)
    assert json_response(conn, 200)["data"] == %{"id" => property.id,
      "display_name" => property.display_name,
      "identifying_name" => property.identifying_name,
      "active" => property.active}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, property_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, property_path(conn, :create), property: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Property, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, property_path(conn, :create), property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = put conn, property_path(conn, :update, property), property: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Property, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = put conn, property_path(conn, :update, property), property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    property = Repo.insert! %Property{}
    conn = delete conn, property_path(conn, :delete, property)
    assert response(conn, 204)
    refute Repo.get(Property, property.id)
  end
end
