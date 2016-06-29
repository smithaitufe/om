defmodule Store.V1.PaymentMethodControllerTest do
  use Store.ConnCase

  alias Store.V1.PaymentMethod
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, payment_method_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    payment_method = Repo.insert! %PaymentMethod{}
    conn = get conn, payment_method_path(conn, :show, payment_method)
    assert json_response(conn, 200)["data"] == %{"id" => payment_method.id,
      "name" => payment_method.name}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, payment_method_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, payment_method_path(conn, :create), payment_method: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(PaymentMethod, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, payment_method_path(conn, :create), payment_method: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    payment_method = Repo.insert! %PaymentMethod{}
    conn = put conn, payment_method_path(conn, :update, payment_method), payment_method: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(PaymentMethod, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    payment_method = Repo.insert! %PaymentMethod{}
    conn = put conn, payment_method_path(conn, :update, payment_method), payment_method: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    payment_method = Repo.insert! %PaymentMethod{}
    conn = delete conn, payment_method_path(conn, :delete, payment_method)
    assert response(conn, 204)
    refute Repo.get(PaymentMethod, payment_method.id)
  end
end
