defmodule   Store.V1.ImageView do
    use Store.Web, :view

    alias Store.Image

    def render("show.json", %{image: image}) do
        render_one(image, Store.V1.ImageView, "image.json")
    end

    def render("image.json", %{image: image}) do
        %{
            id: image.id,
            name: image.name,
            urls: %{
                original: Image.url(image, :original),
                thumb: Image.url(image, :thumb),
                show: Image.url(image, :show),
                slide: Image.url(image, :slide)
            }
        }
    end

end