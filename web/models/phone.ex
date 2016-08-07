defmodule Store.Phone do
  use Ecto.Schema
  import Ecto.Changeset

  schema "phones" do
    field :number, :string

    timestamps
  end

  @required_fields ~w(number)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:number])
    |> validate_required([:number])
  end
end
