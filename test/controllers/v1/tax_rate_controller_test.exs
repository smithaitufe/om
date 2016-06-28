defmodule Store.V1.TaxRateControllerTest do
  use Store.ConnCase

  alias Store.V1.TaxRate
  @valid_attrs %{end_date: "2010-04-17", percentage: 42, start_date: "2010-04-17"}
  @invalid_attrs %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tax_rate_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    tax_rate = Repo.insert! %TaxRate{}
    conn = get conn, tax_rate_path(conn, :show, tax_rate)
    assert json_response(conn, 200)["data"] == %{"id" => tax_rate.id,
      "country_id" => tax_rate.country_id,
      "percentage" => tax_rate.percentage,
      "start_date" => tax_rate.start_date,
      "end_date" => tax_rate.end_date}
  end

  test "does not show resource and instead throw error when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, tax_rate_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, tax_rate_path(conn, :create), tax_rate: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(TaxRate, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tax_rate_path(conn, :create), tax_rate: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    tax_rate = Repo.insert! %TaxRate{}
    conn = put conn, tax_rate_path(conn, :update, tax_rate), tax_rate: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(TaxRate, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tax_rate = Repo.insert! %TaxRate{}
    conn = put conn, tax_rate_path(conn, :update, tax_rate), tax_rate: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    tax_rate = Repo.insert! %TaxRate{}
    conn = delete conn, tax_rate_path(conn, :delete, tax_rate)
    assert response(conn, 204)
    refute Repo.get(TaxRate, tax_rate.id)
  end
end
