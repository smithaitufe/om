defmodule Store.ImageTest do
  use Store.ModelCase

  alias Store.Image

  @valid_attrs %{height: 42, name: "some content", url: "some content", width: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Image.changeset(%Image{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Image.changeset(%Image{}, @invalid_attrs)
    refute changeset.valid?
  end
end
