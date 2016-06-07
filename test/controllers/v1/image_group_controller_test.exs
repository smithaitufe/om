defmodule Store.V1.ImageGroupControllerTest do
  use Store.ConnCase

  alias Store.V1.ImageGroup
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, image_group_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    image_group = Repo.insert! %ImageGroup{}
    conn = get conn, image_group_path(conn, :show, image_group)
    assert json_response(conn, 200)["data"] == %{"id" => image_group.id,
      "name" => image_group.name,
      "product_id" => image_group.product_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, image_group_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, image_group_path(conn, :create), image_group: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(ImageGroup, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, image_group_path(conn, :create), image_group: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    image_group = Repo.insert! %ImageGroup{}
    conn = put conn, image_group_path(conn, :update, image_group), image_group: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(ImageGroup, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    image_group = Repo.insert! %ImageGroup{}
    conn = put conn, image_group_path(conn, :update, image_group), image_group: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    image_group = Repo.insert! %ImageGroup{}
    conn = delete conn, image_group_path(conn, :delete, image_group)
    assert response(conn, 204)
    refute Repo.get(ImageGroup, image_group.id)
  end
end
