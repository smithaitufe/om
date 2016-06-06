defmodule Store.V1.ReviewControllerTest do
  use Store.ConnCase

  alias Store.V1.Review
  @valid_attrs %{comment: "some content", rating: 42}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, review_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    review = Repo.insert! %Review{}
    conn = get conn, review_path(conn, :show, review)
    assert json_response(conn, 200)["data"] == %{"id" => review.id,
      "user_id" => review.user_id,
      "product_id" => review.product_id,
      "comment" => review.comment,
      "rating" => review.rating}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, review_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, review_path(conn, :create), review: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Review, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, review_path(conn, :create), review: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    review = Repo.insert! %Review{}
    conn = put conn, review_path(conn, :update, review), review: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Review, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    review = Repo.insert! %Review{}
    conn = put conn, review_path(conn, :update, review), review: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    review = Repo.insert! %Review{}
    conn = delete conn, review_path(conn, :delete, review)
    assert response(conn, 204)
    refute Repo.get(Review, review.id)
  end
end
