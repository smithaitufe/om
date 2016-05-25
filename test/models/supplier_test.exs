defmodule Store.SupplierTest do
  use Store.ModelCase

  alias Store.Supplier

  @valid_attrs %{email: "some content", name: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Supplier.changeset(%Supplier{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Supplier.changeset(%Supplier{}, @invalid_attrs)
    refute changeset.valid?
  end
end
