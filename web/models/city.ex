defmodule Store.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field :name, :string
    belongs_to :state, Store.State
    belongs_to :shipping_zone, Store.ShippingZone

    has_many :addresses, Store.Address

    timestamps
  end

  @required_fields [:name, :state_id, :shipping_zone_id]
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
end
