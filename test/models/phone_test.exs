defmodule Store.PhoneTest do
  use Store.ModelCase

  alias Store.Phone

  @valid_attrs %{number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Phone.changeset(%Phone{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Phone.changeset(%Phone{}, @invalid_attrs)
    refute changeset.valid?
  end
end
