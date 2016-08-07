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


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:country_id, :shipping_zone_id, :name, :described_as, :abbreviation])
    |> validate_required([:country_id, :shipping_zone_id, :name, :abbreviation])
  end
end
