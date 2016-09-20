defmodule Store.V1.VariantPropertyControllerTest do
  use Store.ConnCase

  alias Store.VariantProperty
  @valid_attrs %{description: "some content", primary: true}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_variant_property_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    variant_property = Repo.insert! %VariantProperty{}
    conn = get conn, v1_variant_property_path(conn, :show, variant_property)
    assert json_response(conn, 200)["data"] == %{"id" => variant_property.id,
      "variant_id" => variant_property.variant_id,
      "property_id" => variant_property.property_id,
      "description" => variant_property.description,
      "primary" => variant_property.primary}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_variant_property_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_variant_property_path(conn, :create), variant_property: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(VariantProperty, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_variant_property_path(conn, :create), variant_property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    variant_property = Repo.insert! %VariantProperty{}
    conn = put conn, v1_variant_property_path(conn, :update, variant_property), variant_property: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(VariantProperty, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    variant_property = Repo.insert! %VariantProperty{}
    conn = put conn, v1_variant_property_path(conn, :update, variant_property), variant_property: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    variant_property = Repo.insert! %VariantProperty{}
    conn = delete conn, v1_variant_property_path(conn, :delete, variant_property)
    assert response(conn, 204)
    refute Repo.get(VariantProperty, variant_property.id)
  end
end
