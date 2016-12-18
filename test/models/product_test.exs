defmodule Store.ProductTest do
  use Store.ModelCase

  alias Store.Product

  @valid_attrs %{available_at: "2010-04-17 14:00:00", deleted_at: "2010-04-17 14:00:00", featured: true, keywords: "some content", long_description: "some content", name: "some content", permalink: "some content", short_description: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Product.changeset(%Product{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Product.changeset(%Product{}, @invalid_attrs)
    refute changeset.valid?
  end
end
