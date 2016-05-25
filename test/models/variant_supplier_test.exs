defmodule Store.VariantSupplierTest do
  use Store.ModelCase

  alias Store.VariantSupplier

  @valid_attrs %{active: true, cost: "120.5", max_quantity: 42, min_quantity: 42, total_quantity_supplied: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = VariantSupplier.changeset(%VariantSupplier{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = VariantSupplier.changeset(%VariantSupplier{}, @invalid_attrs)
    refute changeset.valid?
  end
end
