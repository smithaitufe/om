defmodule Store.OptionGroupTest do
  use Store.ModelCase

  alias Store.OptionGroup

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = OptionGroup.changeset(%OptionGroup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = OptionGroup.changeset(%OptionGroup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
