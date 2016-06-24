defmodule Store.V1.CityController do
  use Store.Web, :controller

  alias Store.City

  plug :scrub_params, "city" when action in [:create, :update]

  def index(conn, _params) do
    cities = Repo.all(City)
    render(conn, "index.json", cities: cities)
  end

  def create(conn, %{"city" => city_params}) do
    changeset = City.changeset(%City{}, city_params)

    case Repo.insert(changeset) do
      {:ok, city} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_city_path(conn, :show, city))
        |> render("show.json", city: city)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    city = Repo.get!(City, id)
    render(conn, "show.json", city: city)
  end

  def update(conn, %{"id" => id, "city" => city_params}) do
    city = Repo.get!(City, id)
    changeset = City.changeset(city, city_params)

    case Repo.update(changeset) do
      {:ok, city} ->
        render(conn, "show.json", city: city)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    city = Repo.get!(City, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(city)

    send_resp(conn, :no_content, "")
  end
end
