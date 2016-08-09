defmodule Store.CartItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cart_items" do
    field :quantity, :integer
    field :active, :boolean, default: false

    belongs_to :cart, Store.Cart
    belongs_to :variant, Store.Variant
    belongs_to :item_type, Store.Term


    timestamps
  end

  @fields ~w(cart_id variant_id item_type_id quantity active)
  @required_fields ~w(cart_id variant_id item_type_id quantity)


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
