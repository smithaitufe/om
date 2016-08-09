defmodule Store.Review do
  use Ecto.Schema
  import Ecto.Changeset

  schema "reviews" do
    field :comment, :string
    field :rating, :integer, default: 0
    belongs_to :user, Store.User
    belongs_to :product, Store.Product

    timestamps
  end

  @fields ~w(user_id product_id comment rating)
  @required_fields ~w(user_id product_id comment)


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
