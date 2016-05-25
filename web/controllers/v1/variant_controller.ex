defmodule Store.V1.VariantController do
  use Store.Web, :controller

  alias Store.V1.Variant

  plug :scrub_params, "variant" when action in [:create, :update]

  def index(conn, _params) do
    variants = Repo.all(Variant)
    render(conn, "index.json", variants: variants)
  end

  def create(conn, %{"variant" => variant_params}) do
    changeset = Variant.changeset(%Variant{}, variant_params)

    case Repo.insert(changeset) do
      {:ok, variant} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_variant_path(conn, :show, variant))
        |> render("show.json", variant: variant)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    variant = Repo.get!(Variant, id)
    render(conn, "show.json", variant: variant)
  end

  def update(conn, %{"id" => id, "variant" => variant_params}) do
    variant = Repo.get!(Variant, id)
    changeset = Variant.changeset(variant, variant_params)

    case Repo.update(changeset) do
      {:ok, variant} ->
        render(conn, "show.json", variant: variant)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    variant = Repo.get!(Variant, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(variant)

    send_resp(conn, :no_content, "")
  end
end
