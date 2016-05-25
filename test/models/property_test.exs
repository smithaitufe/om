defmodule Store.PropertyTest do
  use Store.ModelCase

  alias Store.Property

  @valid_attrs %{active: true, display_name: "some content", identifying_name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Property.changeset(%Property{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Property.changeset(%Property{}, @invalid_attrs)
    refute changeset.valid?
  end
end
