defmodule Store.ProductCategory do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_categories" do
    field :name, :string
    field :description, :string
    field :active, :boolean, default: true
    field :slug, :string
    belongs_to :parent, Store.ProductCategory
    has_many :products, Store.Product


    timestamps
  end

  @optional_fields ~w(description active slug parent_id)a
  @required_fields ~w(name)a

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(product_category, params \\ %{}) do
    product_category
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> generate_slug()

  end


  defp generate_slug(changeset) do
    if name = get_change(changeset, :name) do
      slug = name
      |> String.downcase
      |> String.replace(~r/[^\w-]+/, "-")
      put_change(changeset, :slug, slug)
    else
      changeset
    end
  end
end
