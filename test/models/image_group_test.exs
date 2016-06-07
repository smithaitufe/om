defmodule Store.ImageGroupTest do
  use Store.ModelCase

  alias Store.ImageGroup

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = ImageGroup.changeset(%ImageGroup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = ImageGroup.changeset(%ImageGroup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
