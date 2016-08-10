defmodule Store.InvoiceStatusTest do
  use Store.ModelCase

  alias Store.InvoiceStatus

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = InvoiceStatus.changeset(%InvoiceStatus{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = InvoiceStatus.changeset(%InvoiceStatus{}, @invalid_attrs)
    refute changeset.valid?
  end
end
