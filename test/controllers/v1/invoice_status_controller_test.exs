defmodule Store.V1.InvoiceStatusControllerTest do
  use Store.ConnCase

  alias Store.InvoiceStatus
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_invoice_status_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    invoice_status = Repo.insert! %InvoiceStatus{}
    conn = get conn, v1_invoice_status_path(conn, :show, invoice_status)
    assert json_response(conn, 200)["data"] == %{"id" => invoice_status.id,
      "name" => invoice_status.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_invoice_status_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_invoice_status_path(conn, :create), invoice_status: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(InvoiceStatus, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_invoice_status_path(conn, :create), invoice_status: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    invoice_status = Repo.insert! %InvoiceStatus{}
    conn = put conn, v1_invoice_status_path(conn, :update, invoice_status), invoice_status: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(InvoiceStatus, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    invoice_status = Repo.insert! %InvoiceStatus{}
    conn = put conn, v1_invoice_status_path(conn, :update, invoice_status), invoice_status: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    invoice_status = Repo.insert! %InvoiceStatus{}
    conn = delete conn, v1_invoice_status_path(conn, :delete, invoice_status)
    assert response(conn, 204)
    refute Repo.get(InvoiceStatus, invoice_status.id)
  end
end
