defmodule Store.OrderStateTest do
  use Store.ModelCase

  alias Store.OrderState

  @valid_attrs %{active: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OrderState.changeset(%OrderState{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OrderState.changeset(%OrderState{}, @invalid_attrs)
    refute changeset.valid?
  end
end
