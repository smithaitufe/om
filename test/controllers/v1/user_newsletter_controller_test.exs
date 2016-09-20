defmodule Store.V1.UserNewsletterControllerTest do
  use Store.ConnCase

  alias Store.UserNewsletter
  @valid_attrs %{}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, v1_user_newsletter_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    user_newsletter = Repo.insert! %UserNewsletter{}
    conn = get conn, v1_user_newsletter_path(conn, :show, user_newsletter)
    assert json_response(conn, 200)["data"] == %{"id" => user_newsletter.id,
      "user_id" => user_newsletter.user_id,
      "newsletter_id" => user_newsletter.newsletter_id}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, v1_user_newsletter_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, v1_user_newsletter_path(conn, :create), user_newsletter: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(UserNewsletter, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, v1_user_newsletter_path(conn, :create), user_newsletter: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    user_newsletter = Repo.insert! %UserNewsletter{}
    conn = put conn, v1_user_newsletter_path(conn, :update, user_newsletter), user_newsletter: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(UserNewsletter, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    user_newsletter = Repo.insert! %UserNewsletter{}
    conn = put conn, v1_user_newsletter_path(conn, :update, user_newsletter), user_newsletter: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    user_newsletter = Repo.insert! %UserNewsletter{}
    conn = delete conn, v1_user_newsletter_path(conn, :delete, user_newsletter)
    assert response(conn, 204)
    refute Repo.get(UserNewsletter, user_newsletter.id)
  end
end
