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

  @required_fields ~w(cost total_quantity_supplied min_quantity max_quantity active)
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
