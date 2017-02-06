defmodule Store.V1.ImageController do
    use Store.Web, :controller
    plug :scrub_params, "image" when action in [:create, :update]

    alias Store.Image

    def index(conn, params) do
        images = Image
        |> build_query(Map.to_list(params))
        |> Repo.all

        render(conn, "index.json", images: images)
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

    defp build_query(query, []), do: query
    defp build_query(query, [{"product_id", product_id} | tail]) do
        query
        |> Ecto.Query.join(:inner, [image], product_image in assoc(image, :product_image))
        |> Ecto.Query.where([image, product_image], product_image.product_id == ^product_id)
        |> build_query(tail)

    end
    defp build_query(query, [{"product_id", product_id} | tail]) do

        # images = Product
        # |> Ecto.Query.join(:inner, [product], product_images in assoc(product, :product_images)
        # |> Ecto.Query.join(:inner, [product, product_images], image in assoc(product_images, :image)
        # |> Ecto.Query.where([product, product_images, image], product.id == ^product_id)
        # |> Ecto.Query.select([_, _, image], [image])
        # |> build_query(tail)


        Store.ProductImage
        |> Ecto.Query.where([product_image], product_image.product_id == ^product_id)
        |> Repo.all()
        |> Ecto.assoc(:image)
        |> build_query(tail)

        # query 
        # |> Ecto.assoc(:product_images) 
        # |> Ecto.Query.where([product_images], product_images.product_id == ^product_id)
        # |> Repo.all
        # |> Ecto.assoc(:image)
        # |> build_query(tail)

        # query
        # |> Ecto.Query.join(:inner, [image], product_image in assoc(image, :product_image))
        # |> Ecto.Query.where([image, product_image], product_image.product_id == ^product_id)
        # |> build_query(tail)

    end





end