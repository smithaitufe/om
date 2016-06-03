defmodule Store.V1.NewsletterController do
  use Store.Web, :controller

  alias Store.Newsletter

  plug :scrub_params, "newsletter" when action in [:create, :update]

  def index(conn, _params) do
    newsletters = Repo.all(Newsletter)
    render(conn, "index.json", newsletters: newsletters)
  end

  def create(conn, %{"newsletter" => newsletter_params}) do
    changeset = Newsletter.changeset(%Newsletter{}, newsletter_params)

    case Repo.insert(changeset) do
      {:ok, newsletter} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_newsletter_path(conn, :show, newsletter))
        |> render("show.json", newsletter: newsletter)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    newsletter = Repo.get!(Newsletter, id)
    render(conn, "show.json", newsletter: newsletter)
  end

  def update(conn, %{"id" => id, "newsletter" => newsletter_params}) do
    newsletter = Repo.get!(Newsletter, id)
    changeset = Newsletter.changeset(newsletter, newsletter_params)

    case Repo.update(changeset) do
      {:ok, newsletter} ->
        render(conn, "show.json", newsletter: newsletter)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    newsletter = Repo.get!(Newsletter, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(newsletter)

    send_resp(conn, :no_content, "")
  end
end
