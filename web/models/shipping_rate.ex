defmodule Store.ShippingRate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shipping_rates" do
    field :minimum, :float
    field :maximum, :float
    field :rate, :decimal
    field :active, :boolean, default: false
    belongs_to :payment_method, Store.PaymentMethod
    belongs_to :shipping_method, Store.ShippingMethod
    belongs_to :shipping_rate_type, Store.ShippingRateType

    timestamps
  end

  @required_fields [:shipping_method_id, :shipping_rate_type_id, :payment_method_id, :minimum, :maximum, :rate]
  @optional_fields [:active]

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
end
