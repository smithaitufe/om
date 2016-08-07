defmodule Store.VariantSupplier do
  use Ecto.Schema

  schema "variant_suppliers" do
    field :cost, :decimal
    field :total_quantity_supplied, :integer
    field :min_quantity, :integer
    field :max_quantity, :integer
    field :active, :boolean, default: false
    belongs_to :variant, Store.Variant
    belongs_to :supplier, Store.Supplier

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:supplier_id, :variant_id, :cost, :total_quantity_supplied, :min_quantity, :max_quantity, :active])
    |> validate_required([:supplier_id, :variant_id, :cost, :total_quantity_supplied, :min_quantity, :max_quantity])
  end
end
