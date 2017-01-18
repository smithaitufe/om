defmodule Store.V1.OptionController do
  use Store.Web, :controller

  alias Store.Option

  def index(conn, _params) do
    options = Repo.all(Option)
    render(conn, "index.json", options: options)
  end

  def create(conn, %{"option" => option_params}) do
    changeset = Option.changeset(%Option{}, option_params)

    case Repo.insert(changeset) do
      {:ok, option} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_option_path(conn, :show, option))
        |> render("show.json", option: option)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    option = Repo.get!(Option, id)
    render(conn, "show.json", option: option)
  end

  def update(conn, %{"id" => id, "option" => option_params}) do
    option = Repo.get!(Option, id)
    changeset = Option.changeset(option, option_params)

    case Repo.update(changeset) do
      {:ok, option} ->
        render(conn, "show.json", option: option)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    option = Repo.get!(Option, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(option)

    send_resp(conn, :no_content, "")
  end
end
