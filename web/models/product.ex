defmodule Store.Product do
  use   Store.Web, :model
  alias Store.{ProductCategory, ShippingCategory, Shop, Tag, ProductTag, Brand, Variant}
  alias Store.{Image, ImageGroup, ProductImage}

  schema "products" do
    field :name, :string
    field :short_description, :string
    field :long_description, :string
    field :available_at, Ecto.DateTime
    field :deleted_at, Ecto.DateTime
    field :permalink, :string
    field :keywords, :string
    field :featured, :boolean, default: false
    field :meta_keywords, :string
    field :meta_description, :string
    
    belongs_to :product_category, ProductCategory
    belongs_to :shipping_category, ShippingCategory
    belongs_to :shop, Shop
    belongs_to :brand, Brand

    many_to_many :tags, Tag, join_through: ProductTag, join_keys: [product_id: :id, tag_id: :id]
    has_many :variants, Variant
    has_many :product_images, ProductImage
    has_many :images, through: [:product_images, :image]
    has_many :image_groups, ImageGroup

    timestamps()



  end

    @required_fields [:shop_id, :brand_id, :product_category_id, :shipping_category_id, :name, :short_description, :keywords]
    @optional_fields [:long_description, :deleted_at, :featured, :available_at, :meta_keywords, :meta_description, :permalink]


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

  def associations do
    import Ecto.Query, only: [from: 2, order_by: 2]
    variant_query = from v in Variant, 
                    order_by: [asc: v.id],
                    preload: [variant_properties: :property]
    [
      :product_category,
      :shipping_category,
      :shop, :brand,
      {:variants, variant_query},
      :images, 
      :image_groups
    ]
  end
end
