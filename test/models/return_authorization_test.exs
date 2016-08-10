defmodule Store.ReturnAuthorizationTest do
  use Store.ModelCase

  alias Store.ReturnAuthorization

  @valid_attrs %{active: true, amount: "120.5", number: "some content", restocking_fee: "120.5"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ReturnAuthorization.changeset(%ReturnAuthorization{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ReturnAuthorization.changeset(%ReturnAuthorization{}, @invalid_attrs)
    refute changeset.valid?
  end
end
