defmodule Store.ProductImage do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_images" do
    belongs_to :product, Store.Product
    belongs_to :image, Store.Image

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:product_id, :image_id])
    |> validate_required([:product_id, :image_id])
  end
end
