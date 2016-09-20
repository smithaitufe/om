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

  @fields ~w(name state_id shipping_zone_id)a
  @required_fields ~w(name state_id shipping_zone_id)a

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
