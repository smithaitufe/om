defmodule Store.V1.ProductTagControllerTest do
  use Store.ConnCase

  alias Store.V1.ProductTag
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, product_tag_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    product_tag = Repo.insert! %ProductTag{}
    conn = get conn, product_tag_path(conn, :show, product_tag)
    assert json_response(conn, 200)["data"] == %{"id" => product_tag.id,
      "product_id" => product_tag.product_id,
      "tag_id" => product_tag.tag_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, product_tag_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, product_tag_path(conn, :create), product_tag: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ProductTag, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, product_tag_path(conn, :create), product_tag: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    product_tag = Repo.insert! %ProductTag{}
    conn = put conn, product_tag_path(conn, :update, product_tag), product_tag: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ProductTag, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    product_tag = Repo.insert! %ProductTag{}
    conn = put conn, product_tag_path(conn, :update, product_tag), product_tag: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    product_tag = Repo.insert! %ProductTag{}
    conn = delete conn, product_tag_path(conn, :delete, product_tag)
    assert response(conn, 204)
    refute Repo.get(ProductTag, product_tag.id)
  end
end
