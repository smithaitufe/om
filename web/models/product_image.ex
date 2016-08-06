defmodule Store.ProductImage do
  use Ecto.Schema

  schema "product_images" do
    belongs_to :product, Store.Product
    belongs_to :image, Store.Image

    timestamps
  end

  @required_fields ~w(product_id image_id)
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
