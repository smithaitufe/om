defmodule Store.Prototype do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prototypes" do
    field :name, :string
    field :active, :boolean, default: false

    timestamps
  end

  @fields ~w(name active)
  @required_fields ~w(name)


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
