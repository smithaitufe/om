defmodule Store.ShippingMethodTest do
  use Store.ModelCase

  alias Store.ShippingMethod

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ShippingMethod.changeset(%ShippingMethod{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ShippingMethod.changeset(%ShippingMethod{}, @invalid_attrs)
    refute changeset.valid?
  end
end
