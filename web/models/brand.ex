defmodule Store.Brand do
  use Store.Web, :model

  schema "brands" do
    field :name, :string
    belongs_to :product_category, Store.ProductCategory

    timestamps

    has_many :products, Store.Product
  end
  @required_fields [:name, :product_category_id]
  @optional_fields []


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
end
