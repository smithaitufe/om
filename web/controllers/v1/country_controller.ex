defmodule Store.V1.CountryController do
  use Store.Web, :controller

  alias Store.Country

  plug :scrub_params, "country" when action in [:create, :update]

  def index(conn, _params) do
    countries = Repo.all(Country)
    render(conn, "index.json", countries: countries)
  end

  def create(conn, %{"country" => country_params}) do
    changeset = Country.changeset(%Country{}, country_params)

    case Repo.insert(changeset) do
      {:ok, country} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_country_path(conn, :show, country))
        |> render("show.json", country: country)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    country = Repo.get!(Country, id)
    render(conn, "show.json", country: country)
  end

  def update(conn, %{"id" => id, "country" => country_params}) do
    country = Repo.get!(Country, id)
    changeset = Country.changeset(country, country_params)

    case Repo.update(changeset) do
      {:ok, country} ->
        render(conn, "show.json", country: country)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    country = Repo.get!(Country, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(country)

    send_resp(conn, :no_content, "")
  end
end
