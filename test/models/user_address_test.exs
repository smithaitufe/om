defmodule Store.UserAddressTest do
  use Store.ModelCase

  alias Store.UserAddress

  @valid_attrs %{active: true, default: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserAddress.changeset(%UserAddress{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserAddress.changeset(%UserAddress{}, @invalid_attrs)
    refute changeset.valid?
  end
end
