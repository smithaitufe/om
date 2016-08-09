defmodule Store.VariantProperty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "variant_properties" do
    field :description, :string
    field :primary, :boolean, default: false
    belongs_to :variant, Store.Variant
    belongs_to :property, Store.Property

    timestamps
  end

  @fields ~w(variant_id property_id description primary)
  @required_fields ~w(variant_id property_id description)
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
