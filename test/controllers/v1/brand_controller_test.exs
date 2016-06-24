defmodule Store.V1.BrandControllerTest do
  use Store.ConnCase

  alias Store.V1.Brand
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, brand_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    brand = Repo.insert! %Brand{}
    conn = get conn, brand_path(conn, :show, brand)
    assert json_response(conn, 200)["data"] == %{"id" => brand.id,
      "name" => brand.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, brand_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, brand_path(conn, :create), brand: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Brand, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, brand_path(conn, :create), brand: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    brand = Repo.insert! %Brand{}
    conn = put conn, brand_path(conn, :update, brand), brand: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Brand, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    brand = Repo.insert! %Brand{}
    conn = put conn, brand_path(conn, :update, brand), brand: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    brand = Repo.insert! %Brand{}
    conn = delete conn, brand_path(conn, :delete, brand)
    assert response(conn, 204)
    refute Repo.get(Brand, brand.id)
  end
end
