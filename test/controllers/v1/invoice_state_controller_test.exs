defmodule Store.V1.InvoiceStateControllerTest do
  use Store.ConnCase

  alias Store.V1.InvoiceState
  @valid_attrs %{active: true}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, invoice_state_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    invoice_state = Repo.insert! %InvoiceState{}
    conn = get conn, invoice_state_path(conn, :show, invoice_state)
    assert json_response(conn, 200)["data"] == %{"id" => invoice_state.id,
      "invoice_id" => invoice_state.invoice_id,
      "invoice_status_id" => invoice_state.invoice_status_id,
      "user_id" => invoice_state.user_id,
      "active" => invoice_state.active}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, invoice_state_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, invoice_state_path(conn, :create), invoice_state: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(InvoiceState, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, invoice_state_path(conn, :create), invoice_state: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    invoice_state = Repo.insert! %InvoiceState{}
    conn = put conn, invoice_state_path(conn, :update, invoice_state), invoice_state: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(InvoiceState, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    invoice_state = Repo.insert! %InvoiceState{}
    conn = put conn, invoice_state_path(conn, :update, invoice_state), invoice_state: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    invoice_state = Repo.insert! %InvoiceState{}
    conn = delete conn, invoice_state_path(conn, :delete, invoice_state)
    assert response(conn, 204)
    refute Repo.get(InvoiceState, invoice_state.id)
  end
end
