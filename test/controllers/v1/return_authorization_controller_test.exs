defmodule Store.V1.ReturnAuthorizationControllerTest do
  use Store.ConnCase

  alias Store.ReturnAuthorization
  @valid_attrs %{active: true, amount: "120.5", number: "some content", restocking_fee: "120.5"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_return_authorization_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    return_authorization = Repo.insert! %ReturnAuthorization{}
    conn = get conn, v1_return_authorization_path(conn, :show, return_authorization)
    assert json_response(conn, 200)["data"] == %{"id" => return_authorization.id,
      "number" => return_authorization.number,
      "amount" => return_authorization.amount,
      "restocking_fee" => return_authorization.restocking_fee,
      "order_id" => return_authorization.order_id,
      "created_by" => return_authorization.created_by,
      "active" => return_authorization.active}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_return_authorization_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_return_authorization_path(conn, :create), return_authorization: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ReturnAuthorization, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_return_authorization_path(conn, :create), return_authorization: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    return_authorization = Repo.insert! %ReturnAuthorization{}
    conn = put conn, v1_return_authorization_path(conn, :update, return_authorization), return_authorization: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ReturnAuthorization, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    return_authorization = Repo.insert! %ReturnAuthorization{}
    conn = put conn, v1_return_authorization_path(conn, :update, return_authorization), return_authorization: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    return_authorization = Repo.insert! %ReturnAuthorization{}
    conn = delete conn, v1_return_authorization_path(conn, :delete, return_authorization)
    assert response(conn, 204)
    refute Repo.get(ReturnAuthorization, return_authorization.id)
  end
end
