defmodule Store.ShippingRateTypeTest do
  use Store.ModelCase

  alias Store.ShippingRateType

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ShippingRateType.changeset(%ShippingRateType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ShippingRateType.changeset(%ShippingRateType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
