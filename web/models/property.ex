defmodule Store.Property do
  use Ecto.Schema
  import Ecto.Changeset

  schema "properties" do
    field :display_name, :string
    field :identifying_name, :string
    field :active, :boolean, default: false

    timestamps
  end

  @required_fields ~w(display_name identifying_name active)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:display_name, :identifying_name, :active])
    |> validate_required([:display_name, :identifying_name, :active])
  end
end
