defmodule Store.VariantProperty do
  use Ecto.Schema
  import Ecto.Changeset
  alias Store.{Variant, Property}

  schema "variant_properties" do
    field :description, :string
    field :primary, :boolean, default: false
    belongs_to :variant, Variant
    belongs_to :property, Property

    timestamps
  end

  @fields ~w(variant_id property_id description primary)a
  @required_fields ~w(variant_id property_id description)a
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
