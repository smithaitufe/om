defmodule Store.City do
  use Ecto.Schema

  schema "cities" do
    field :name, :string
    belongs_to :state, Store.State

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:name, :state_id])
    |> validate_required([:name, :state_id])
  end
end
