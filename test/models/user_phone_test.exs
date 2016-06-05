defmodule Store.UserPhoneTest do
  use Store.ModelCase

  alias Store.UserPhone

  @valid_attrs %{}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = UserPhone.changeset(%UserPhone{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = UserPhone.changeset(%UserPhone{}, @invalid_attrs)
    refute changeset.valid?
  end
end
