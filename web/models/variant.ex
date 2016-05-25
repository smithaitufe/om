defmodule Store.Variant do
  use Store.Web, :model

  schema "variants" do
    field :sku, :string
    field :name, :string
    field :price, :decimal
    field :compare_price, :decimal
    field :master, :boolean, default: false
    field :quantity_on_hand, :integer
    field :quantity_pending_to_customer, :integer
    field :quantity_pending_from_supplier, :integer
    field :deleted_at, Ecto.DateTime
    belongs_to :product, Store.Product

    timestamps
  end

  @required_fields ~w(product_id sku name price compare_price master quantity_on_hand quantity_pending_to_customer quantity_pending_from_supplier deleted_at)
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
