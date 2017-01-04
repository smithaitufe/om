defmodule Store.State do
  use     Store.Web, :model
  alias   Store.{Country, ShippingZone}


  schema "states" do
    field :name, :string
    field :described_as, :string
    field :abbreviation, :string
    belongs_to :country, Country
    belongs_to :shipping_zone, ShippingZone

    timestamps
  end

  @required_fields [:name, :country_id, :shipping_zone_id]
  @optional_fields [:described_as, :abbreviation]


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
