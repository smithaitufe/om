defmodule Store.V1.CountryControllerTest do
  use Store.ConnCase

  alias Store.V1.Country
  @valid_attrs %{abbreviation: "some content", active: true, name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, country_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    country = Repo.insert! %Country{}
    conn = get conn, country_path(conn, :show, country)
    assert json_response(conn, 200)["data"] == %{"id" => country.id,
      "name" => country.name,
      "abbreviation" => country.abbreviation,
      "shipping_zone_id" => country.shipping_zone_id,
      "active" => country.active}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, country_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, country_path(conn, :create), country: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Country, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, country_path(conn, :create), country: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    country = Repo.insert! %Country{}
    conn = put conn, country_path(conn, :update, country), country: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Country, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    country = Repo.insert! %Country{}
    conn = put conn, country_path(conn, :update, country), country: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    country = Repo.insert! %Country{}
    conn = delete conn, country_path(conn, :delete, country)
    assert response(conn, 204)
    refute Repo.get(Country, country.id)
  end
end
