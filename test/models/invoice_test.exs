defmodule Store.InvoiceTest do
  use Store.ModelCase

  alias Store.Invoice

  @valid_attrs %{active: true, amount: "120.5", number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Invoice.changeset(%Invoice{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Invoice.changeset(%Invoice{}, @invalid_attrs)
    refute changeset.valid?
  end
end
