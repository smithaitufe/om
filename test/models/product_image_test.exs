defmodule Store.ProductImageTest do
  use Store.ModelCase

  alias Store.ProductImage

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ProductImage.changeset(%ProductImage{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ProductImage.changeset(%ProductImage{}, @invalid_attrs)
    refute changeset.valid?
  end
end
