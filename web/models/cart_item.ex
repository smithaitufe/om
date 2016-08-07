defmodule Store.CartItem do
  use Ecto.Schema

  schema "cart_items" do
    field :quantity, :integer
    field :active, :boolean, default: false

    belongs_to :cart, Store.Cart
    belongs_to :variant, Store.Variant
    belongs_to :item_type, Store.ItemType

    timestamps
  end

  @required_fields ~w(cart_id variant_id item_type_id quantity active)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct    
    |> cast(params, [:cart_id, :variant_id, :item_type_id, :quantity, :active])
    |> validate_required([:cart_id, :variant_id, :item_type_id, :quantity])
  end
end
