defmodule Store.Newsletter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "newsletters" do
    field :name, :string
    field :autosubscribe, :boolean, default: false

    timestamps
  end

  @fields ~w(name autosubscribe)
  @required_fields ~w(name autosubscribe)

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
