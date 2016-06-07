defmodule Store.V1.ImageGroupController do
  use Store.Web, :controller

  alias Store.ImageGroup

  plug :scrub_params, "image_group" when action in [:create, :update]

  def index(conn, _params) do
    image_groups = Repo.all(ImageGroup)
    render(conn, "index.json", image_groups: image_groups)
  end

  def create(conn, %{"image_group" => image_group_params}) do
    changeset = ImageGroup.changeset(%ImageGroup{}, image_group_params)

    case Repo.insert(changeset) do
      {:ok, image_group} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_image_group_path(conn, :show, image_group))
        |> render("show.json", image_group: image_group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    image_group = Repo.get!(ImageGroup, id)
    render(conn, "show.json", image_group: image_group)
  end

  def update(conn, %{"id" => id, "image_group" => image_group_params}) do
    image_group = Repo.get!(ImageGroup, id)
    changeset = ImageGroup.changeset(image_group, image_group_params)

    case Repo.update(changeset) do
      {:ok, image_group} ->
        render(conn, "show.json", image_group: image_group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    image_group = Repo.get!(ImageGroup, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(image_group)

    send_resp(conn, :no_content, "")
  end
end
