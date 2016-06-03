defmodule Store.ItemTypeTest do
  use Store.ModelCase

  alias Store.ItemType

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ItemType.changeset(%ItemType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ItemType.changeset(%ItemType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
