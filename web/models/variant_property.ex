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

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:variant_id, :property_id, :primary, :description])
    |> validate_required([:variant_id, :property_id, :description])
  end
end
