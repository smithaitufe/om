defmodule Store.OrderItem do
  use Store.Web, :model

  schema "order_items" do
    field :price, :decimal
    field :quantity, :integer
    field :total, :decimal
    field :state, :string
    belongs_to :order, Store.Order
    belongs_to :variant, Store.Variant

    timestamps
  end

  @required_fields [:order_id, :variant_id, :price, :quantity]
  @optional_fields [:state]

  @doc """
  Creates a changeset based on the `struct` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> calculate_total
  end
end
