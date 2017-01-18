defmodule Store.V1.OptionGroupControllerTest do
  use Store.ConnCase

  alias Store.V1.OptionGroup
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, option_group_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    option_group = Repo.insert! %OptionGroup{}
    conn = get conn, option_group_path(conn, :show, option_group)
    assert json_response(conn, 200)["data"] == %{"id" => option_group.id,
      "shop_id" => option_group.shop_id,
      "name" => option_group.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, option_group_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, option_group_path(conn, :create), option_group: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(OptionGroup, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, option_group_path(conn, :create), option_group: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    option_group = Repo.insert! %OptionGroup{}
    conn = put conn, option_group_path(conn, :update, option_group), option_group: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(OptionGroup, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    option_group = Repo.insert! %OptionGroup{}
    conn = put conn, option_group_path(conn, :update, option_group), option_group: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    option_group = Repo.insert! %OptionGroup{}
    conn = delete conn, option_group_path(conn, :delete, option_group)
    assert response(conn, 204)
    refute Repo.get(OptionGroup, option_group.id)
  end
end
