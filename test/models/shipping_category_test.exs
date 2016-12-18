defmodule Store.ShippingCategoryTest do
  use Store.ModelCase

  alias Store.ShippingCategory

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ShippingCategory.changeset(%ShippingCategory{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ShippingCategory.changeset(%ShippingCategory{}, @invalid_attrs)
    refute changeset.valid?
  end
end
