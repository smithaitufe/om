defmodule Store.Property do
  use Ecto.Schema
  import Ecto.Changeset

  schema "properties" do
    field :display_name, :string
    field :identifying_name, :string
    field :active, :boolean, default: false

    timestamps
  end

  @fields ~w(display_name identifying_name active)
  @required_fields ~w(display_name identifying_name)


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
