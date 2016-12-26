defmodule Store.OrderItemTest do
  use Store.ModelCase

  alias Store.OrderItem

  @valid_attrs %{price: "120.5", quantity: 42, state: "some content", total: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OrderItem.changeset(%OrderItem{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OrderItem.changeset(%OrderItem{}, @invalid_attrs)
    refute changeset.valid?
  end
end
