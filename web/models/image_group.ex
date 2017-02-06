defmodule Store.ImageGroup do
  use Store.Web, :model

  schema "image_groups" do
    field :name, :string
    belongs_to :product, Store.Product

    timestamps()
  end

  @required_fields [:name, :product_id]
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

  def associations do
    [{:product, Store.Product.associations}]
  end

end
