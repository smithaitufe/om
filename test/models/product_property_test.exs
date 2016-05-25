defmodule Store.ProductPropertyTest do
  use Store.ModelCase

  alias Store.ProductProperty

  @valid_attrs %{description: "some content", position: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProductProperty.changeset(%ProductProperty{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProductProperty.changeset(%ProductProperty{}, @invalid_attrs)
    refute changeset.valid?
  end
end
