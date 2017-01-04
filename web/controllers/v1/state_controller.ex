defmodule Store.V1.StateController do
  use Store.Web, :controller

  alias Store.State

  plug :scrub_params, "state" when action in [:create, :update]

  def index(conn, params) do
    states = State
    |> Repo.all
    |> Repo.preload(State.associations)

    render(conn, "index.json", states: states)
  end

  def create(conn, %{"state" => state_params}) do
    changeset = State.changeset(%State{}, state_params)

    case Repo.insert(changeset) do
      {:ok, state} ->
        state = state 
        |> Repo.preload(State.associations)

        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_state_path(conn, :show, state))
        |> render("show.json", state: state)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    state = Repo.get!(State, id)
    |> Repo.preload(State.associations)

    render(conn, "show.json", state: state)
  end

  def update(conn, %{"id" => id, "state" => state_params}) do
    state = Repo.get!(State, id)
    changeset = State.changeset(state, state_params)

    case Repo.update(changeset) do
      {:ok, state} ->
        state = state
        |> Repo.preload(State.associations)
        
        render(conn, "show.json", state: state)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    state = Repo.get!(State, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(state)

    send_resp(conn, :no_content, "")
  end
end
