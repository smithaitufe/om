defmodule Store.V1.NewsletterView do
  use Store.Web, :view

  def render("index.json", %{newsletters: newsletters}) do
    %{data: render_many(newsletters, Store.V1.NewsletterView, "newsletter.json")}
  end

  def render("show.json", %{newsletter: newsletter}) do
    %{data: render_one(newsletter, Store.V1.NewsletterView, "newsletter.json")}
  end

  def render("newsletter.json", %{newsletter: newsletter}) do
    %{id: newsletter.id,
      name: newsletter.name,
      autosubscribe: newsletter.autosubscribe}
  end
end
