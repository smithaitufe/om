defmodule Store.Property do
  use Store.Web, :model

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
    |> cast(params, @required_fields, @optional_fields)
  end
end
