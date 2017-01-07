defmodule Store.CartItem do
  use Store.Web, :model

  schema "cart_items" do
    field :quantity, :integer, default: 1
    field :active, :boolean, default: false

    belongs_to :cart, Store.Cart
    belongs_to :variant, Store.Variant
    belongs_to :item_type, Store.Term


    timestamps
  end

  @required_fields [:cart_id, :variant_id, :item_type_id]
  @optional_fields [:active, :quantity]


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def associations do
    
  end
end
