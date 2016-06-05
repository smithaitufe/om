defmodule Store.CouponTest do
  use Store.ModelCase

  alias Store.Coupon

  @valid_attrs %{amount: "120.5", code: "some content", combine: true, expires_at: "2010-04-17 14:00:00", minimum_value: "120.5", percent: 42, starts_at: "2010-04-17 14:00:00", type: "some content", description: "some description"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Coupon.changeset(%Coupon{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Coupon.changeset(%Coupon{}, @invalid_attrs)
    refute changeset.valid?
  end
end
