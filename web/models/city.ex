defmodule Store.City do
  use Ecto.Schema

  schema "cities" do
    field :name, :string
    belongs_to :state, Store.State

    timestamps
  end

  @required_fields ~w(name state_id)
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
