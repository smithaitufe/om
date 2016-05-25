defmodule Store.V1.ProductControllerTest do
  use Store.ConnCase

  alias Store.V1.Product
  @valid_attrs %{available_at: "2010-04-17 14:00:00", deleted_at: "2010-04-17 14:00:00", featured: true, keywords: "some content", long_description: "some content", name: "some content", permalink: "some content", short_description: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, product_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = get conn, product_path(conn, :show, product)
    assert json_response(conn, 200)["data"] == %{"id" => product.id,
      "name" => product.name,
      "short_description" => product.short_description,
      "long_description" => product.long_description,
      "product_category_id" => product.product_category_id,
      "shipping_category_id" => product.shipping_category_id,
      "available_at" => product.available_at,
      "deleted_at" => product.deleted_at,
      "permalink" => product.permalink,
      "keywords" => product.keywords,
      "featured" => product.featured}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, product_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, product_path(conn, :create), product: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Product, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, product_path(conn, :create), product: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = put conn, product_path(conn, :update, product), product: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Product, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = put conn, product_path(conn, :update, product), product: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    product = Repo.insert! %Product{}
    conn = delete conn, product_path(conn, :delete, product)
    assert response(conn, 204)
    refute Repo.get(Product, product.id)
  end
end
