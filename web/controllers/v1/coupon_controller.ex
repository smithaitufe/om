defmodule Store.V1.CouponController do
  use Store.Web, :controller

  alias Store.Coupon

  plug :scrub_params, "coupon" when action in [:create, :update]

  def index(conn, _params) do
    coupons = Repo.all(Coupon)
    render(conn, "index.json", coupons: coupons)
  end

  def create(conn, %{"coupon" => coupon_params}) do
    changeset = Coupon.changeset(%Coupon{}, coupon_params)

    case Repo.insert(changeset) do
      {:ok, coupon} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", v1_coupon_path(conn, :show, coupon))
        |> render("show.json", coupon: coupon)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    coupon = Repo.get!(Coupon, id)
    render(conn, "show.json", coupon: coupon)
  end

  def update(conn, %{"id" => id, "coupon" => coupon_params}) do
    coupon = Repo.get!(Coupon, id)
    changeset = Coupon.changeset(coupon, coupon_params)

    case Repo.update(changeset) do
      {:ok, coupon} ->
        render(conn, "show.json", coupon: coupon)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Store.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    coupon = Repo.get!(Coupon, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(coupon)

    send_resp(conn, :no_content, "")
  end
end
