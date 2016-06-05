defmodule Store.AddressTest do
  use Store.ModelCase

  alias Store.Address

  @valid_attrs %{address1: "some content", address2: "some content", city: "some content", country_id: "some content", state_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Address.changeset(%Address{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Address.changeset(%Address{}, @invalid_attrs)
    refute changeset.valid?
  end
end
