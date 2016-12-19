defmodule Store.Variant do
  use Ecto.Schema
  import Ecto.Changeset
  alias Store.{Variant, Product, VariantSupplier, VariantProperty, ImageGroup}

  schema "variants" do
    field :sku, :string
    field :name, :string
    field :price, :decimal
    field :compare_price, :decimal
    field :master, :boolean, default: false
    field :quantity_on_hand, :integer
    field :quantity_pending_to_customer, :integer
    field :quantity_pending_from_supplier, :integer
    field :weight, :float, default: 0.0
    field :deleted_at, Ecto.DateTime
    belongs_to :product, Product
    belongs_to :image_group, ImageGroup

    has_many :variant_suppliers, VariantSupplier
    has_many :suppliers, through: [:variant_suppliers, :supplier]

    has_many :variant_properties, VariantProperty
    has_many :properties, through: [:variant_properties, :variant]


    timestamps
  end

  @required_fields ~w(product_id sku name price weight)a
  @optional_fields ~w(quantity_on_hand quantity_pending_to_customer quantity_pending_from_supplier master compare_price image_group_id deleted_at)a



  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def quantity_on_hand(model \\ %Variant{}) do
  end
  def quantity_available(model \\ %Variant{}) do
  end
  def associations do    
    [:suppliers, :properties, :product]
  end

end
