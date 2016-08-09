defmodule Store.Variant do
  use Ecto.Schema
  import Ecto.Changeset

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
    belongs_to :image_group, Store.ImageGroup

    timestamps
  end

  @fields ~w(product_id sku name price quantity_on_hand quantity_pending_to_customer quantity_pending_from_supplier master compare_price image_group_id deleted_at)
  @required_fields ~w(product_id sku name price quantity_on_hand quantity_pending_to_customer quantity_pending_from_supplier)


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
