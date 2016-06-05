defmodule Store.Country do
  use Store.Web, :model

  schema "countries" do
    field :name, :string
    field :abbreviation, :string
    field :active, :boolean, default: false
    belongs_to :shipping_zone, Store.ShippingZone

    timestamps
  end

  @required_fields ~w(name abbreviation active)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
