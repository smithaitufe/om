defmodule Store.ShippingRateTest do
  use Store.ModelCase

  alias Store.ShippingRate

  @valid_attrs %{active: true, maximum: "120.5", minimum: "120.5", rate: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ShippingRate.changeset(%ShippingRate{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ShippingRate.changeset(%ShippingRate{}, @invalid_attrs)
    refute changeset.valid?
  end
end
