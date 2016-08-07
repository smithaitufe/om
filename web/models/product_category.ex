defmodule Store.ProductCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_categories" do
    field :name, :string
    field :description, :string
    field :active, :boolean, default: true
    belongs_to :parent, Store.Parent

    timestamps
  end

  @required_fields ~w(name description active)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:name, :description, :active])
    |> validate_required([:name, :description])

  end
end
