defmodule Store.ReturnConditionTest do
  use Store.ModelCase

  alias Store.ReturnCondition

  @valid_attrs %{description: "some content", label: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ReturnCondition.changeset(%ReturnCondition{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ReturnCondition.changeset(%ReturnCondition{}, @invalid_attrs)
    refute changeset.valid?
  end
end
