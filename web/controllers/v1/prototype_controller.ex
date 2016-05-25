defmodule Store.V1.PrototypeController do
  use Store.Web, :controller

  alias Store.Prototype

  plug :scrub_params, "prototype" when action in [:create, :update]

  def index(conn, _params) do
    prototypes = Repo.all(Prototype)
    render(conn, "index.json", prototypes: prototypes)
  end

  def create(conn, %{"prototype" => prototype_params}) do
    changeset = Prototype.changeset(%Prototype{}, prototype_params)

    case Repo.insert(changeset) do
      {:ok, prototype} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_prototype_path(conn, :show, prototype))
        |> render("show.json", prototype: prototype)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    prototype = Repo.get!(Prototype, id)
    render(conn, "show.json", prototype: prototype)
  end

  def update(conn, %{"id" => id, "prototype" => prototype_params}) do
    prototype = Repo.get!(Prototype, id)
    changeset = Prototype.changeset(prototype, prototype_params)

    case Repo.update(changeset) do
      {:ok, prototype} ->
        render(conn, "show.json", prototype: prototype)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    prototype = Repo.get!(Prototype, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(prototype)

    send_resp(conn, :no_content, "")
  end
end
