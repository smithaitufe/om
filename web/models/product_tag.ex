defmodule Store.ProductTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_tags" do
    belongs_to :product, Store.Product
    belongs_to :tag, Store.Tag

    timestamps
  end

  @fields ~w(product_id tag_id)a
  @required_fields ~w(product_id tag_id)a


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
