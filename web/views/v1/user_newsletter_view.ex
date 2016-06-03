defmodule Store.V1.UserNewsletterView do
  use Store.Web, :view

  def render("index.json", %{user_newsletters: user_newsletters}) do
    %{data: render_many(user_newsletters, Store.V1.UserNewsletterView, "user_newsletter.json")}
  end

  def render("show.json", %{user_newsletter: user_newsletter}) do
    %{data: render_one(user_newsletter, Store.V1.UserNewsletterView, "user_newsletter.json")}
  end

  def render("user_newsletter.json", %{user_newsletter: user_newsletter}) do
    %{id: user_newsletter.id,
      user_id: user_newsletter.user_id,
      newsletter_id: user_newsletter.newsletter_id}
  end
end
