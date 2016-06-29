defmodule Store.ShopTest do
  use Store.ModelCase

  alias Store.Shop

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Shop.changeset(%Shop{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Shop.changeset(%Shop{}, @invalid_attrs)
    refute changeset.valid?
  end
end
