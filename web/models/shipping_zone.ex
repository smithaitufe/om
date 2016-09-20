defmodule Store.ShippingZone do
  use Ecto.Schema
  import Ecto.Changeset
  # import Ecto.Changeset, only: [cast: 3]

  schema "shipping_zones" do
    field :name, :string

    timestamps
  end

  @fields [:name]
  @required_fields [:name]


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
