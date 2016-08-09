defmodule Store.ImageGroup do
  use Ecto.Schema
  import Ecto.Changeset

  schema "image_groups" do
    field :name, :string
    belongs_to :product, Store.Product

    timestamps
  end

  @fields ~w(name product_id)a
  @required_fields ~w(name product_id)a

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
