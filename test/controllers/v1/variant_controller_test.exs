defmodule Store.V1.VariantControllerTest do
  use Store.ConnCase

  alias Store.Variant
  @valid_attrs %{compare_price: "120.5", deleted_at: "2010-04-17 14:00:00", master: true, name: "some content", price: "120.5", quantity_on_hand: 42, quantity_pending_from_supplier: 42, quantity_pending_to_customer: 42, sku: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_variant_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    variant = Repo.insert! %Variant{}
    conn = get conn, v1_variant_path(conn, :show, variant)
    assert json_response(conn, 200)["data"] == %{"id" => variant.id,
      "product_id" => variant.product_id,
      "sku" => variant.sku,
      "name" => variant.name,
      "price" => variant.price,
      "compare_price" => variant.compare_price,
      "master" => variant.master,
      "quantity_on_hand" => variant.quantity_on_hand,
      "quantity_pending_to_customer" => variant.quantity_pending_to_customer,
      "quantity_pending_from_supplier" => variant.quantity_pending_from_supplier,
      "deleted_at" => variant.deleted_at}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_variant_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_variant_path(conn, :create), variant: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Variant, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_variant_path(conn, :create), variant: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    variant = Repo.insert! %Variant{}
    conn = put conn, v1_variant_path(conn, :update, variant), variant: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Variant, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    variant = Repo.insert! %Variant{}
    conn = put conn, v1_variant_path(conn, :update, variant), variant: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    variant = Repo.insert! %Variant{}
    conn = delete conn, v1_variant_path(conn, :delete, variant)
    assert response(conn, 204)
    refute Repo.get(Variant, variant.id)
  end
end
