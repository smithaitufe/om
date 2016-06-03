defmodule Store.CartItem do
  use Store.Web, :model

  schema "cart_items" do
    field :quantity, :integer
    field :active, :boolean, default: false

    belongs_to :cart, Store.Cart
    belongs_to :variant, Store.Variant
    belongs_to :item_type, Store.ItemType

    timestamps
  end

  @required_fields ~w(quantity active)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
