defmodule Store.TaxRateTest do
  use Store.ModelCase

  alias Store.TaxRate

  @valid_attrs %{end_date: "2010-04-17", percentage: 42, start_date: "2010-04-17"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TaxRate.changeset(%TaxRate{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TaxRate.changeset(%TaxRate{}, @invalid_attrs)
    refute changeset.valid?
  end
end
