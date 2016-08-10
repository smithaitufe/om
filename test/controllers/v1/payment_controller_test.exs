defmodule Store.V1.PaymentControllerTest do
  use Store.ConnCase

  alias Store.V1.Payment
  @valid_attrs %{cleared: true, error: "some content", error_code: "some content", success: true}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, payment_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    payment = Repo.insert! %Payment{}
    conn = get conn, payment_path(conn, :show, payment)
    assert json_response(conn, 200)["data"] == %{"id" => payment.id,
      "invoice_id" => payment.invoice_id,
      "payment_method_id" => payment.payment_method_id,
      "success" => payment.success,
      "cleared" => payment.cleared,
      "cleared_by_user_id" => payment.cleared_by_user_id,
      "error_code" => payment.error_code,
      "error" => payment.error}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, payment_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, payment_path(conn, :create), payment: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Payment, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, payment_path(conn, :create), payment: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    payment = Repo.insert! %Payment{}
    conn = put conn, payment_path(conn, :update, payment), payment: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Payment, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    payment = Repo.insert! %Payment{}
    conn = put conn, payment_path(conn, :update, payment), payment: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    payment = Repo.insert! %Payment{}
    conn = delete conn, payment_path(conn, :delete, payment)
    assert response(conn, 204)
    refute Repo.get(Payment, payment.id)
  end
end
