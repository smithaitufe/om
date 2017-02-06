defmodule Store.ProductConditionTest do
  use Store.ModelCase

  alias Store.ProductCondition

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProductCondition.changeset(%ProductCondition{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProductCondition.changeset(%ProductCondition{}, @invalid_attrs)
    refute changeset.valid?
  end
end
