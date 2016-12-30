defmodule Store.ShippingCategory do
  use Store.Web, :model

  schema "shipping_categories" do
    field :name, :string
    field :description, :string

    has_many :products, Store.Product

    timestamps
  end

  @required_fields [:name]
  @optional_fields [:description]


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 2, max: 255)
  end
end
