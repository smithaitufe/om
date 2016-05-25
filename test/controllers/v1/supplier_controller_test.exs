defmodule Store.V1.SupplierControllerTest do
  use Store.ConnCase

  alias Store.V1.Supplier
  @valid_attrs %{email: "some content", name: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, supplier_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    supplier = Repo.insert! %Supplier{}
    conn = get conn, supplier_path(conn, :show, supplier)
    assert json_response(conn, 200)["data"] == %{"id" => supplier.id,
      "name" => supplier.name,
      "email" => supplier.email,
      "phone_number" => supplier.phone_number}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, supplier_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, supplier_path(conn, :create), supplier: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Supplier, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, supplier_path(conn, :create), supplier: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    supplier = Repo.insert! %Supplier{}
    conn = put conn, supplier_path(conn, :update, supplier), supplier: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Supplier, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    supplier = Repo.insert! %Supplier{}
    conn = put conn, supplier_path(conn, :update, supplier), supplier: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    supplier = Repo.insert! %Supplier{}
    conn = delete conn, supplier_path(conn, :delete, supplier)
    assert response(conn, 204)
    refute Repo.get(Supplier, supplier.id)
  end
end
