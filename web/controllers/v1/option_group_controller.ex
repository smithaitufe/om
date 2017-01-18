defmodule Store.V1.OptionGroupController do
  use Store.Web, :controller

  alias Store.OptionGroup

  def index(conn, _params) do
    option_groups = Repo.all(OptionGroup)
    render(conn, "index.json", option_groups: option_groups)
  end

  def create(conn, %{"option_group" => option_group_params}) do
    changeset = OptionGroup.changeset(%OptionGroup{}, option_group_params)

    case Repo.insert(changeset) do
      {:ok, option_group} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_option_group_path(conn, :show, option_group))
        |> render("show.json", option_group: option_group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    option_group = Repo.get!(OptionGroup, id)
    render(conn, "show.json", option_group: option_group)
  end

  def update(conn, %{"id" => id, "option_group" => option_group_params}) do
    option_group = Repo.get!(OptionGroup, id)
    changeset = OptionGroup.changeset(option_group, option_group_params)

    case Repo.update(changeset) do
      {:ok, option_group} ->
        render(conn, "show.json", option_group: option_group)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    option_group = Repo.get!(OptionGroup, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(option_group)

    send_resp(conn, :no_content, "")
  end
end
