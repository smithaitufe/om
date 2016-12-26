defmodule Store.V1.ItemTypeController do
  use Store.Web, :controller

  alias Store.ItemType

  plug :scrub_params, "item_type" when action in [:create, :update]

  def index(conn, _params) do
    item_types = Repo.all(ItemType)
    render(conn, "index.json", item_types: item_types)
  end

  def create(conn, %{"item_type" => item_type_params}) do
    changeset = ItemType.changeset(%ItemType{}, item_type_params)

    case Repo.insert(changeset) do
      {:ok, item_type} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_item_type_path(conn, :show, item_type))
        |> render("show.json", item_type: item_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    item_type = Repo.get!(ItemType, id)
    render(conn, "show.json", item_type: item_type)
  end

  def update(conn, %{"id" => id, "item_type" => item_type_params}) do
    item_type = Repo.get!(ItemType, id)
    changeset = ItemType.changeset(item_type, item_type_params)

    case Repo.update(changeset) do
      {:ok, item_type} ->
        render(conn, "show.json", item_type: item_type)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    item_type = Repo.get!(ItemType, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(item_type)

    send_resp(conn, :no_content, "")
  end
end