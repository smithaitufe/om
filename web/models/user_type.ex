defmodule Store.UserType do
  use Store.Web, :model

  schema "user_types" do
    field :name, :string
    field :description, :string
    field :code, :string

    timestamps
  end

  @required_fields ~w(name description code)
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