defmodule Store.Cart do
use Store.Web, :model
alias Store.{CartItem, User, Variant}

  schema "carts" do
    belongs_to :user, User
    has_many :cart_items, CartItem
    timestamps
  end

  
  @required_fields [:user_id]
  @optional_fields []

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
    cart_items_query = from ci in CartItem,
                      order_by: [asc: ci.inserted_at], 
                      preload: [{:variant, ^Variant.associations}]

    [cart_items: cart_items_query]
  end
end
