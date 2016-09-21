defmodule Store.State do
  use Ecto.Schema


  schema "states" do
    field :name, :string
    field :described_as, :string
    field :abbreviation, :string
    belongs_to :country, Store.Country
    belongs_to :shipping_zone, Store.ShippingZone

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
    |> Ecto.Changeset.cast(params, @required_fields <> @optional_fields)
    |> validate_required(@required_fields)
  end
end
