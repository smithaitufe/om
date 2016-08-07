defmodule Store.ImageGroup do
  use Ecto.Schema

  schema "image_groups" do
    field :name, :string
    belongs_to :product, Store.Product

    timestamps
  end

  @fields ~w(name product_id)
  @required_fields ~w(name product_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
