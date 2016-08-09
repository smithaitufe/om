defmodule Store.ProductProperty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_properties" do
    field :position, :integer
    field :description, :string
    belongs_to :product, Store.Product
    belongs_to :property, Store.Property

    timestamps
  end

  @fields ~w(product_id property_id position description)a
  @required_fields ~w(product_id property_id position description)a


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
