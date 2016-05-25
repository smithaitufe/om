defmodule Store.V1.VariantPropertyController do
  use Store.Web, :controller

  alias Store.VariantProperty

  plug :scrub_params, "variant_property" when action in [:create, :update]

  def index(conn, _params) do
    variant_properties = Repo.all(VariantProperty)
    render(conn, "index.json", variant_properties: variant_properties)
  end

  def create(conn, %{"variant_property" => variant_property_params}) do
    changeset = VariantProperty.changeset(%VariantProperty{}, variant_property_params)

    case Repo.insert(changeset) do
      {:ok, variant_property} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_variant_property_path(conn, :show, variant_property))
        |> render("show.json", variant_property: variant_property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    variant_property = Repo.get!(VariantProperty, id)
    render(conn, "show.json", variant_property: variant_property)
  end

  def update(conn, %{"id" => id, "variant_property" => variant_property_params}) do
    variant_property = Repo.get!(VariantProperty, id)
    changeset = VariantProperty.changeset(variant_property, variant_property_params)

    case Repo.update(changeset) do
      {:ok, variant_property} ->
        render(conn, "show.json", variant_property: variant_property)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    variant_property = Repo.get!(VariantProperty, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(variant_property)

    send_resp(conn, :no_content, "")
  end
end
