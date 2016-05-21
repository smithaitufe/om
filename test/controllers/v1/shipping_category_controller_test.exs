defmodule Store.V1.ShippingCategoryControllerTest do
  use Store.ConnCase

  alias Store.V1.ShippingCategory
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, shipping_category_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    shipping_category = Repo.insert! %ShippingCategory{}
    conn = get conn, shipping_category_path(conn, :show, shipping_category)
    assert json_response(conn, 200)["data"] == %{"id" => shipping_category.id,
      "name" => shipping_category.name,
      "description" => shipping_category.description}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, shipping_category_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, shipping_category_path(conn, :create), shipping_category: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ShippingCategory, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, shipping_category_path(conn, :create), shipping_category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    shipping_category = Repo.insert! %ShippingCategory{}
    conn = put conn, shipping_category_path(conn, :update, shipping_category), shipping_category: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ShippingCategory, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    shipping_category = Repo.insert! %ShippingCategory{}
    conn = put conn, shipping_category_path(conn, :update, shipping_category), shipping_category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    shipping_category = Repo.insert! %ShippingCategory{}
    conn = delete conn, shipping_category_path(conn, :delete, shipping_category)
    assert response(conn, 204)
    refute Repo.get(ShippingCategory, shipping_category.id)
  end
end
