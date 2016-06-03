defmodule Store.V1.UserNewsletterController do
  use Store.Web, :controller

  alias Store.UserNewsletter

  plug :scrub_params, "user_newsletter" when action in [:create, :update]

  def index(conn, _params) do
    user_newsletters = Repo.all(UserNewsletter)
    render(conn, "index.json", user_newsletters: user_newsletters)
  end

  def create(conn, %{"user_newsletter" => user_newsletter_params}) do
    changeset = UserNewsletter.changeset(%UserNewsletter{}, user_newsletter_params)

    case Repo.insert(changeset) do
      {:ok, user_newsletter} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_user_newsletter_path(conn, :show, user_newsletter))
        |> render("show.json", user_newsletter: user_newsletter)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user_newsletter = Repo.get!(UserNewsletter, id)
    render(conn, "show.json", user_newsletter: user_newsletter)
  end

  def update(conn, %{"id" => id, "user_newsletter" => user_newsletter_params}) do
    user_newsletter = Repo.get!(UserNewsletter, id)
    changeset = UserNewsletter.changeset(user_newsletter, user_newsletter_params)

    case Repo.update(changeset) do
      {:ok, user_newsletter} ->
        render(conn, "show.json", user_newsletter: user_newsletter)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user_newsletter = Repo.get!(UserNewsletter, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(user_newsletter)

    send_resp(conn, :no_content, "")
  end
end
