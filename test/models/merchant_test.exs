defmodule Store.MerchantTest do
  use Store.ModelCase

  alias Store.Merchant

  @valid_attrs %{email: "some content", name: "some content", phone_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Merchant.changeset(%Merchant{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Merchant.changeset(%Merchant{}, @invalid_attrs)
    refute changeset.valid?
  end
end
