defmodule Store.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "carts" do
    belongs_to :user, Store.User
    has_many :cart_items, Store.CartItem
    timestamps
  end

  @fields ~w(user_id)
  @required_fields ~w(user_id)

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
