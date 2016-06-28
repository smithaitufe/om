defmodule Store.LocalGovernmentAreaTest do
  use Store.ModelCase

  alias Store.LocalGovernmentArea

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = LocalGovernmentArea.changeset(%LocalGovernmentArea{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = LocalGovernmentArea.changeset(%LocalGovernmentArea{}, @invalid_attrs)
    refute changeset.valid?
  end
end
