defmodule Store.V1.ReturnConditionController do
  use Store.Web, :controller

  alias Store.ReturnCondition

  plug :scrub_params, "return_condition" when action in [:create, :update]

  def index(conn, _params) do
    return_conditions = Repo.all(ReturnCondition)
    render(conn, "index.json", return_conditions: return_conditions)
  end

  def create(conn, %{"return_condition" => return_condition_params}) do
    changeset = ReturnCondition.changeset(%ReturnCondition{}, return_condition_params)

    case Repo.insert(changeset) do
      {:ok, return_condition} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_return_condition_path(conn, :show, return_condition))
        |> render("show.json", return_condition: return_condition)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    return_condition = Repo.get!(ReturnCondition, id)
    render(conn, "show.json", return_condition: return_condition)
  end

  def update(conn, %{"id" => id, "return_condition" => return_condition_params}) do
    return_condition = Repo.get!(ReturnCondition, id)
    changeset = ReturnCondition.changeset(return_condition, return_condition_params)

    case Repo.update(changeset) do
      {:ok, return_condition} ->
        render(conn, "show.json", return_condition: return_condition)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    return_condition = Repo.get!(ReturnCondition, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(return_condition)

    send_resp(conn, :no_content, "")
  end
end
