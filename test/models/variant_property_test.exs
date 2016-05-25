defmodule Store.VariantPropertyTest do
  use Store.ModelCase

  alias Store.VariantProperty

  @valid_attrs %{description: "some content", primary: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = VariantProperty.changeset(%VariantProperty{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = VariantProperty.changeset(%VariantProperty{}, @invalid_attrs)
    refute changeset.valid?
  end
end
