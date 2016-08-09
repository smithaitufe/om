defmodule Store.ShippingMethod do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shipping_methods" do
    field :name, :string
    belongs_to :shipping_zone, Store.ShippingZone

    timestamps
  end

  @fields ~w(shipping_zone_id name)
  @required_fields ~w(shipping_zone_id name)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
