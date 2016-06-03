defmodule Store.CartTest do
  use Store.ModelCase

  alias Store.Cart

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Cart.changeset(%Cart{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Cart.changeset(%Cart{}, @invalid_attrs)
    refute changeset.valid?
  end
end
