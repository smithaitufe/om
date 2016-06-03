defmodule Store.NewsletterTest do
  use Store.ModelCase

  alias Store.Newsletter

  @valid_attrs %{autosubscribe: true, name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Newsletter.changeset(%Newsletter{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Newsletter.changeset(%Newsletter{}, @invalid_attrs)
    refute changeset.valid?
  end
end
