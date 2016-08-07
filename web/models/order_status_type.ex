defmodule Store.OrderStatusType do
  use Ecto.Schema

  schema "order_status_types" do
    field :name, :string

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
