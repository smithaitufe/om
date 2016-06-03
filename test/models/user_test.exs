defmodule Store.UserTest do
  use Store.ModelCase

  alias Store.User

  @valid_attrs %{active: true, email: "some content", encrypted_password: "some content", first_name: "some content", last_name: "some content", lock_expires_at: "2010-04-17 14:00:00", locked: true, login_attempts: 42, reset_token: "some content", reset_token_created_at: "2010-04-17 14:00:00", reset_token_expires_at: "2010-04-17 14:00:00"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = User.changeset(%User{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = User.changeset(%User{}, @invalid_attrs)
    refute changeset.valid?
  end
end
