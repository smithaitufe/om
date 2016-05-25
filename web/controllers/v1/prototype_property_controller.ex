defmodule Store.V1.PrototypePropertyController do
  use Store.Web, :controller

  alias Store.PrototypeProperty

  plug :scrub_params, "prototype_property" when action in [:create, :update]

  def index(conn, _params) do
    prototype_properties = Repo.all(PrototypeProperty)
    render(conn, "index.json", prototype_properties: prototype_properties)
  end

  def create(conn, %{"prototype_property" => prototype_property_params}) do
    changeset = PrototypeProperty.changeset(%PrototypeProperty{}, prototype_property_params)

    case Repo.insert(changeset) do
      {:ok, prototype_property} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_prototype_property_path(conn, :show, prototype_property))
        |> render("show.json", prototype_property: prototype_property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    prototype_property = Repo.get!(PrototypeProperty, id)
    render(conn, "show.json", prototype_property: prototype_property)
  end

  def update(conn, %{"id" => id, "prototype_property" => prototype_property_params}) do
    prototype_property = Repo.get!(PrototypeProperty, id)
    changeset = PrototypeProperty.changeset(prototype_property, prototype_property_params)

    case Repo.update(changeset) do
      {:ok, prototype_property} ->
        render(conn, "show.json", prototype_property: prototype_property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    prototype_property = Repo.get!(PrototypeProperty, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(prototype_property)

    send_resp(conn, :no_content, "")
  end
end
