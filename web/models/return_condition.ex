defmodule Store.ReturnCondition do
  use Ecto.Schema
  import Ecto.Changeset

  schema "return_conditions" do
    field :label, :string
    field :description, :string

    timestamps
  end

  @fields ~w(label description)a
  @required_fields ~w(label description)a


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
