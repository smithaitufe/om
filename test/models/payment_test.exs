defmodule Store.PaymentTest do
  use Store.ModelCase

  alias Store.Payment

  @valid_attrs %{cleared: true, error: "some content", error_code: "some content", success: true}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Payment.changeset(%Payment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Payment.changeset(%Payment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
