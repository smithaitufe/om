defmodule Store.V1.InvoiceTypeControllerTest do
  use Store.ConnCase

  alias Store.InvoiceType
  @valid_attrs %{name: "some content", slug: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_invoice_type_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    invoice_type = Repo.insert! %InvoiceType{}
    conn = get conn, v1_invoice_type_path(conn, :show, invoice_type)
    assert json_response(conn, 200)["data"] == %{"id" => invoice_type.id,
      "name" => invoice_type.name,
      "slug" => invoice_type.slug}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_invoice_type_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_invoice_type_path(conn, :create), invoice_type: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(InvoiceType, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_invoice_type_path(conn, :create), invoice_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    invoice_type = Repo.insert! %InvoiceType{}
    conn = put conn, v1_invoice_type_path(conn, :update, invoice_type), invoice_type: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(InvoiceType, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    invoice_type = Repo.insert! %InvoiceType{}
    conn = put conn, v1_invoice_type_path(conn, :update, invoice_type), invoice_type: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    invoice_type = Repo.insert! %InvoiceType{}
    conn = delete conn, v1_invoice_type_path(conn, :delete, invoice_type)
    assert response(conn, 204)
    refute Repo.get(InvoiceType, invoice_type.id)
  end
end
