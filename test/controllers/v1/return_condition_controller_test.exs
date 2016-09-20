defmodule Store.V1.ReturnConditionControllerTest do
  use Store.ConnCase

  alias Store.ReturnCondition
  @valid_attrs %{description: "some content", label: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_return_condition_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    return_condition = Repo.insert! %ReturnCondition{}
    conn = get conn, v1_return_condition_path(conn, :show, return_condition)
    assert json_response(conn, 200)["data"] == %{"id" => return_condition.id,
      "label" => return_condition.label,
      "description" => return_condition.description}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_return_condition_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_return_condition_path(conn, :create), return_condition: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ReturnCondition, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_return_condition_path(conn, :create), return_condition: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    return_condition = Repo.insert! %ReturnCondition{}
    conn = put conn, v1_return_condition_path(conn, :update, return_condition), return_condition: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ReturnCondition, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    return_condition = Repo.insert! %ReturnCondition{}
    conn = put conn, v1_return_condition_path(conn, :update, return_condition), return_condition: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    return_condition = Repo.insert! %ReturnCondition{}
    conn = delete conn, v1_return_condition_path(conn, :delete, return_condition)
    assert response(conn, 204)
    refute Repo.get(ReturnCondition, return_condition.id)
  end
end
