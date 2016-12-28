defmodule Store.ShopUserTest do
  use Store.ModelCase

  alias Store.ShopUser

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ShopUser.changeset(%ShopUser{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ShopUser.changeset(%ShopUser{}, @invalid_attrs)
    refute changeset.valid?
  end
end
