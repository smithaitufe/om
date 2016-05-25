defmodule Store.ProductCategory do
  use Store.Web, :model

  schema "product_categories" do
    field :name, :string
    field :description, :string
    field :active, :boolean, default: false
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
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
