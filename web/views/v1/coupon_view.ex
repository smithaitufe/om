defmodule Store.V1.CouponView do
  use Store.Web, :view

  def render("index.json", %{coupons: coupons}) do
    render_many(coupons, Store.V1.CouponView, "coupon.json")
  end

  def render("show.json", %{coupon: coupon}) do
    render_one(coupon, Store.V1.CouponView, "coupon.json")
  end

  def render("coupon.json", %{coupon: coupon}) do
    %{id: coupon.id,
      type: coupon.type,
      code: coupon.code,
      description: coupon.description,
      amount: coupon.amount,
      minimum_value: coupon.minimum_value,
      percent: coupon.percent,
      combine: coupon.combine,
      starts_at: coupon.starts_at,
      expires_at: coupon.expires_at}
  end
end
