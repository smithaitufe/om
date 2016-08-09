defmodule Store.ShippingZone do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shipping_zones" do
    field :name, :string

    timestamps
  end

  @fields ~w(name)a
  @required_fields ~w(name)a


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
