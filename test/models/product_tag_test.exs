defmodule Store.ProductTagTest do
  use Store.ModelCase

  alias Store.ProductTag

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProductTag.changeset(%ProductTag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProductTag.changeset(%ProductTag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
