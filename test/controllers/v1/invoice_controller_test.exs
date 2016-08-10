defmodule Store.V1.InvoiceControllerTest do
  use Store.ConnCase

  alias Store.V1.Invoice
  @valid_attrs %{active: true, amount: "120.5", number: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, invoice_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    invoice = Repo.insert! %Invoice{}
    conn = get conn, invoice_path(conn, :show, invoice)
    assert json_response(conn, 200)["data"] == %{"id" => invoice.id,
      "order_id" => invoice.order_id,
      "invoice_type_id" => invoice.invoice_type_id,
      "invoice_status_id" => invoice.invoice_status_id,
      "number" => invoice.number,
      "amount" => invoice.amount,
      "active" => invoice.active,
      "created_by_user_id" => invoice.created_by_user_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, invoice_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, invoice_path(conn, :create), invoice: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Invoice, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, invoice_path(conn, :create), invoice: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    invoice = Repo.insert! %Invoice{}
    conn = put conn, invoice_path(conn, :update, invoice), invoice: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Invoice, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    invoice = Repo.insert! %Invoice{}
    conn = put conn, invoice_path(conn, :update, invoice), invoice: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    invoice = Repo.insert! %Invoice{}
    conn = delete conn, invoice_path(conn, :delete, invoice)
    assert response(conn, 204)
    refute Repo.get(Invoice, invoice.id)
  end
end
