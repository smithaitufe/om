defmodule Store.LocalGovernmentArea do
  use Ecto.Schema

  schema "local_government_areas" do
    field :name, :string
    belongs_to :state, Store.State

    timestamps
  end

  @fields ~w(name state_id)
  @required_fields ~w(name state_id)

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
