defmodule Store.State do
  use Ecto.Schema
  import Ecto.Changeset

  schema "states" do
    field :name, :string
    field :described_as, :string
    field :abbreviation, :string
    belongs_to :country, Store.Country
    belongs_to :shipping_zone, Store.ShippingZone

    timestamps
  end

  @fields ~w(name described_as abbreviation country_id shipping_zone_id)a
  @required_fields ~w(name country_id shipping_zone_id)a

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
