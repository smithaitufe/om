defmodule Store.Review do
  use Ecto.Schema

  schema "reviews" do
    field :comment, :string
    field :rating, :integer
    belongs_to :user, Store.User
    belongs_to :product, Store.Product

    timestamps
  end

  @required_fields ~w(comment rating)
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
