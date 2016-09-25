defmodule Store.State do
  use     Ecto.Schema
  import  Ecto.Changeset
  alias   Store.{Country, ShippingZone}


  schema "states" do
    field :name, :string
    field :described_as, :string
    field :abbreviation, :string
    belongs_to :country, Country
    belongs_to :shipping_zone, ShippingZone

    timestamps
  end

  @required_fields ~w(name country_id shipping_zone_id)a
  @optional_fields ~w(described_as abbreviation)a


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
