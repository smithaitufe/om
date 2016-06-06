defmodule Store.V1.ReviewView do
  use Store.Web, :view

  def render("index.json", %{reviews: reviews}) do
    %{data: render_many(reviews, Store.V1.ReviewView, "review.json")}
  end

  def render("show.json", %{review: review}) do
    %{data: render_one(review, Store.V1.ReviewView, "review.json")}
  end

  def render("review.json", %{review: review}) do
    %{id: review.id,
      user_id: review.user_id,
      product_id: review.product_id,
      comment: review.comment,
      rating: review.rating}
  end
end
