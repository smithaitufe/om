defmodule Store.ShippingCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shipping_categories" do
    field :name, :string
    field :description, :string
    has_many :products, Store.Product
    timestamps
  end

  @fields ~w(name description)a
  @required_fields ~w(name description)a


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
