defmodule Store.PhoneTypeTest do
  use Store.ModelCase

  alias Store.PhoneType

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PhoneType.changeset(%PhoneType{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PhoneType.changeset(%PhoneType{}, @invalid_attrs)
    refute changeset.valid?
  end
end
