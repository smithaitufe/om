defmodule Store.Product do
  use Ecto.Schema

  schema "products" do
    field :name, :string
    field :short_description, :string
    field :long_description, :string
    field :available_at, Ecto.DateTime
    field :deleted_at, Ecto.DateTime
    field :permalink, :string
    field :keywords, :string
    field :featured, :boolean, default: false
    belongs_to :product_category, Store.ProductCategory
    belongs_to :shipping_category, Store.ShippingCategory
    belongs_to :shop, Store.Shop
    belongs_to :brand, Store.Brand

    timestamps
  end



  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:brand_id, :product_category_id, :shipping_category_id, :name, :short_description, :long_description, :available_at, :deleted_at, :permalink, :keywords, :featured])
    |> validate_required([:brand_id, :product_category_id, :shipping_category_id, :name, :short_description, :long_description, :available_at, :deleted_at, :permalink, :keywords, :featured])
  end
end
