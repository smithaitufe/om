defmodule Store.VariantProperty do
  use Ecto.Schema

  schema "variant_properties" do
    field :description, :string
    field :primary, :boolean, default: false
    belongs_to :variant, Store.Variant
    belongs_to :property, Store.Property

    timestamps
  end

  @required_fields ~w(variant_id property_id description primary)
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
