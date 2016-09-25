defmodule Store.InvoiceStateTest do
  use Store.ModelCase

  alias Store.InvoiceState

  @valid_attrs %{active: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = InvoiceState.changeset(%InvoiceState{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = InvoiceState.changeset(%InvoiceState{}, @invalid_attrs)
    refute changeset.valid?
  end
end
