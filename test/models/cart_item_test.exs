defmodule Store.CartItemTest do
  use Store.ModelCase

  alias Store.CartItem

  @valid_attrs %{active: true, iactive: true, quantity: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = CartItem.changeset(%CartItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = CartItem.changeset(%CartItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
