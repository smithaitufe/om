defmodule Store.V1.ProductPropertyControllerTest do
  use Store.ConnCase

  alias Store.V1.ProductProperty
  @valid_attrs %{description: "some content", position: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, product_property_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    product_property = Repo.insert! %ProductProperty{}
    conn = get conn, product_property_path(conn, :show, product_property)
    assert json_response(conn, 200)["data"] == %{"id" => product_property.id,
      "product_id" => product_property.product_id,
      "property_id" => product_property.property_id,
      "position" => product_property.position,
      "description" => product_property.description}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, product_property_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, product_property_path(conn, :create), product_property: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ProductProperty, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, product_property_path(conn, :create), product_property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    product_property = Repo.insert! %ProductProperty{}
    conn = put conn, product_property_path(conn, :update, product_property), product_property: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ProductProperty, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product_property = Repo.insert! %ProductProperty{}
    conn = put conn, product_property_path(conn, :update, product_property), product_property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    product_property = Repo.insert! %ProductProperty{}
    conn = delete conn, product_property_path(conn, :delete, product_property)
    assert response(conn, 204)
    refute Repo.get(ProductProperty, product_property.id)
  end
end
