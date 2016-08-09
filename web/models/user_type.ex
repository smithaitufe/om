defmodule Store.UserType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_types" do
    field :name, :string
    field :description, :string
    field :code, :string

    timestamps
  end

  @fields ~w(name description code)
  @required_fields ~w(name description code)


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
