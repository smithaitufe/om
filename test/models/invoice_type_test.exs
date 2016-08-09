defmodule Store.InvoiceTypeTest do
  use Store.ModelCase

  alias Store.InvoiceType

  @valid_attrs %{name: "some content", slug: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = InvoiceType.changeset(%InvoiceType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = InvoiceType.changeset(%InvoiceType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
