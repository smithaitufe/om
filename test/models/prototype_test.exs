defmodule Store.PrototypeTest do
  use Store.ModelCase

  alias Store.Prototype

  @valid_attrs %{active: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Prototype.changeset(%Prototype{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Prototype.changeset(%Prototype{}, @invalid_attrs)
    refute changeset.valid?
  end
end
