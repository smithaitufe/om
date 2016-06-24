defmodule Store.Supplier do
  use Store.Web, :model

  schema "suppliers" do
    field :name, :string
    field :email, :string
    field :phone_number, :string

    timestamps
  end

  @required_fields ~w(name email phone_number)
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