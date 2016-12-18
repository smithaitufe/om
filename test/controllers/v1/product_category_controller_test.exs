defmodule Store.V1.ProductCategoryControllerTest do
  use Store.ConnCase

  alias Store.ProductCategory
  @valid_attrs %{active: true, description: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_product_category_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    product_category = Repo.insert! %ProductCategory{}
    conn = get conn, v1_product_category_path(conn, :show, product_category)
    assert json_response(conn, 200)["data"] == %{"id" => product_category.id,
      "name" => product_category.name,
      "description" => product_category.description,
      "parent_id" => product_category.parent_id,
      "active" => product_category.active}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_product_category_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_product_category_path(conn, :create), product_category: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ProductCategory, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_product_category_path(conn, :create), product_category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    product_category = Repo.insert! %ProductCategory{}
    conn = put conn, v1_product_category_path(conn, :update, product_category), product_category: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ProductCategory, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product_category = Repo.insert! %ProductCategory{}
    conn = put conn, v1_product_category_path(conn, :update, product_category), product_category: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    product_category = Repo.insert! %ProductCategory{}
    conn = delete conn, v1_product_category_path(conn, :delete, product_category)
    assert response(conn, 204)
    refute Repo.get(ProductCategory, product_category.id)
  end
end
