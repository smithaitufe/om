defmodule Store.PaymentMethodTest do
  use Store.ModelCase

  alias Store.PaymentMethod

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PaymentMethod.changeset(%PaymentMethod{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PaymentMethod.changeset(%PaymentMethod{}, @invalid_attrs)
    refute changeset.valid?
  end
end
