defmodule Store.ProductProperty do
  use Ecto.Schema

  schema "product_properties" do
    field :position, :integer
    field :description, :string
    belongs_to :product, Store.Product
    belongs_to :property, Store.Property

    timestamps
  end

  @required_fields ~w(product_id property_id position description)
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
