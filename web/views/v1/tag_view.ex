defmodule Store.V1.TagView do
  use Store.Web, :view

  def render("index.json", %{tags: tags}) do
    %{data: render_many(tags, Store.V1.TagView, "tag.json")}
  end

  def render("show.json", %{tag: tag}) do
    %{data: render_one(tag, Store.V1.TagView, "tag.json")}
  end

  def render("tag.json", %{tag: tag}) do
    %{id: tag.id,
      name: tag.name,
      slug: tag.slug,
      description: tag.description}
  end
end
