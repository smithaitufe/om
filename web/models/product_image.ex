defmodule Store.ProductImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_images" do
    belongs_to :product, Store.Product
    belongs_to :image, Store.Image

    timestamps
  end

  @fields ~w(product_id image_id)
  @required_fields ~w(product_id image_id)

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
