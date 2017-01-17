defmodule Store.V1.ImageController do
    use Store.Web, :controller
    plug :scrub_params, "image" when action in [:create, :update]

    alias Store.Image

    def index(conn, _params) do
        
    end
    def create(conn, %{"image" => image_params}) do
        params = %{upload: image_params}
        changeset = Image.attachment_changeset(%Image{}, params)        

        case Repo.insert(changeset) do
            {:ok, image} ->
                Image.store(image_params, image)

                conn            
                |> put_status(:created)
                |> put_resp_header("location", v1_image_path(conn, :show, image))
                |> render("show.json", image: image)
            {:error, changeset} ->
                conn
                |> put_status(:unprocessable_entity)
                |> render(Store.ChangesetView, "error.json", changeset: changeset)
        end
    end

    # def create(conn, params) do
    #     IO.inspect params
    # end
end