defmodule Store.V1.VariantSupplierControllerTest do
  use Store.ConnCase

  alias Store.V1.VariantSupplier
  @valid_attrs %{active: true, cost: "120.5", max_quantity: 42, min_quantity: 42, total_quantity_supplied: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, variant_supplier_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    variant_supplier = Repo.insert! %VariantSupplier{}
    conn = get conn, variant_supplier_path(conn, :show, variant_supplier)
    assert json_response(conn, 200)["data"] == %{"id" => variant_supplier.id,
      "variant_id" => variant_supplier.variant_id,
      "supplier_id" => variant_supplier.supplier_id,
      "cost" => variant_supplier.cost,
      "total_quantity_supplied" => variant_supplier.total_quantity_supplied,
      "min_quantity" => variant_supplier.min_quantity,
      "max_quantity" => variant_supplier.max_quantity,
      "active" => variant_supplier.active}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, variant_supplier_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, variant_supplier_path(conn, :create), variant_supplier: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(VariantSupplier, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, variant_supplier_path(conn, :create), variant_supplier: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    variant_supplier = Repo.insert! %VariantSupplier{}
    conn = put conn, variant_supplier_path(conn, :update, variant_supplier), variant_supplier: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(VariantSupplier, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    variant_supplier = Repo.insert! %VariantSupplier{}
    conn = put conn, variant_supplier_path(conn, :update, variant_supplier), variant_supplier: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    variant_supplier = Repo.insert! %VariantSupplier{}
    conn = delete conn, variant_supplier_path(conn, :delete, variant_supplier)
    assert response(conn, 204)
    refute Repo.get(VariantSupplier, variant_supplier.id)
  end
end
