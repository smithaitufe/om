defmodule Store.V1.ImageController do
    use Store.Web, :controller
    plug :scrub_params, "image" when action in [:create, :update]

    def index(conn, _params) do
        
    end
    def create(conn, %{"image" => image_params}) do
        
    end
end