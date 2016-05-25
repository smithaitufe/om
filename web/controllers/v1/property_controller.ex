defmodule Store.V1.PropertyController do
  use Store.Web, :controller

  alias Store.Property

  plug :scrub_params, "property" when action in [:create, :update]

  def index(conn, _params) do
    properties = Repo.all(Property)
    render(conn, "index.json", properties: properties)
  end

  def create(conn, %{"property" => property_params}) do
    changeset = Property.changeset(%Property{}, property_params)

    case Repo.insert(changeset) do
      {:ok, property} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_property_path(conn, :show, property))
        |> render("show.json", property: property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    property = Repo.get!(Property, id)
    render(conn, "show.json", property: property)
  end

  def update(conn, %{"id" => id, "property" => property_params}) do
    property = Repo.get!(Property, id)
    changeset = Property.changeset(property, property_params)

    case Repo.update(changeset) do
      {:ok, property} ->
        render(conn, "show.json", property: property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    property = Repo.get!(Property, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(property)

    send_resp(conn, :no_content, "")
  end
end
