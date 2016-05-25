defmodule Store.PrototypePropertyTest do
  use Store.ModelCase

  alias Store.PrototypeProperty

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PrototypeProperty.changeset(%PrototypeProperty{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PrototypeProperty.changeset(%PrototypeProperty{}, @invalid_attrs)
    refute changeset.valid?
  end
end
