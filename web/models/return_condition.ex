defmodule Store.ReturnCondition do
  use Store.Web, :model

  schema "return_conditions" do
    field :label, :string
    field :description, :string

    timestamps
  end

  @required_fields ~w(label description)
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
