defmodule Store.ShippingMethod do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shipping_methods" do
    field :name, :string
    field :minimum_days, :integer
    field :maximum_days, :integer
    field :rate, :decimal
    belongs_to :shipping_zone, Store.ShippingZone

    timestamps
  end

  @fields ~w(shipping_zone_id name minimum_days maximum_days rate)a
  @required_fields ~w(shipping_zone_id name rate)a

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
