defmodule Store.V1.NewsletterControllerTest do
  use Store.ConnCase

  alias Store.Newsletter
  @valid_attrs %{autosubscribe: true, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_newsletter_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    newsletter = Repo.insert! %Newsletter{}
    conn = get conn, v1_newsletter_path(conn, :show, newsletter)
    assert json_response(conn, 200)["data"] == %{"id" => newsletter.id,
      "name" => newsletter.name,
      "autosubscribe" => newsletter.autosubscribe}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_newsletter_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_newsletter_path(conn, :create), newsletter: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Newsletter, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_newsletter_path(conn, :create), newsletter: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    newsletter = Repo.insert! %Newsletter{}
    conn = put conn, v1_newsletter_path(conn, :update, newsletter), newsletter: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Newsletter, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    newsletter = Repo.insert! %Newsletter{}
    conn = put conn, v1_newsletter_path(conn, :update, newsletter), newsletter: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    newsletter = Repo.insert! %Newsletter{}
    conn = delete conn, v1_newsletter_path(conn, :delete, newsletter)
    assert response(conn, 204)
    refute Repo.get(Newsletter, newsletter.id)
  end
end
