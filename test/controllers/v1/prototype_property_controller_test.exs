defmodule Store.V1.PrototypePropertyControllerTest do
  use Store.ConnCase

  alias Store.PrototypeProperty
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_prototype_property_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    prototype_property = Repo.insert! %PrototypeProperty{}
    conn = get conn, v1_prototype_property_path(conn, :show, prototype_property)
    assert json_response(conn, 200)["data"] == %{"id" => prototype_property.id,
      "prototype_id" => prototype_property.prototype_id,
      "property_id" => prototype_property.property_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_prototype_property_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_prototype_property_path(conn, :create), prototype_property: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(PrototypeProperty, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_prototype_property_path(conn, :create), prototype_property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    prototype_property = Repo.insert! %PrototypeProperty{}
    conn = put conn, v1_prototype_property_path(conn, :update, prototype_property), prototype_property: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(PrototypeProperty, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    prototype_property = Repo.insert! %PrototypeProperty{}
    conn = put conn, v1_prototype_property_path(conn, :update, prototype_property), prototype_property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    prototype_property = Repo.insert! %PrototypeProperty{}
    conn = delete conn, v1_prototype_property_path(conn, :delete, prototype_property)
    assert response(conn, 204)
    refute Repo.get(PrototypeProperty, prototype_property.id)
  end
end
