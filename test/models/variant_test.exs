defmodule Store.VariantTest do
  use Store.ModelCase

  alias Store.Variant

  @valid_attrs %{compare_price: "120.5", deleted_at: "2010-04-17 14:00:00", master: true, name: "some content", price: "120.5", quantity_on_hand: 42, quantity_pending_from_supplier: 42, quantity_pending_to_customer: 42, sku: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Variant.changeset(%Variant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Variant.changeset(%Variant{}, @invalid_attrs)
    refute changeset.valid?
  end
end
