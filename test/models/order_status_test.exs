defmodule Store.OrderStatusTest do
  use Store.ModelCase

  alias Store.OrderStatus

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OrderStatus.changeset(%OrderStatus{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OrderStatus.changeset(%OrderStatus{}, @invalid_attrs)
    refute changeset.valid?
  end
end
