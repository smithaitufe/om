defmodule Store.ShippingZoneTest do
  use Store.ModelCase

  alias Store.ShippingZone

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ShippingZone.changeset(%ShippingZone{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ShippingZone.changeset(%ShippingZone{}, @invalid_attrs)
    refute changeset.valid?
  end
end
