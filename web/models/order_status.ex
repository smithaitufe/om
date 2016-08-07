defmodule Store.OrderStatus do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_statuses" do
    field :active, :boolean, default: false
    belongs_to :order, Store.Order
    belongs_to :order_status_type, Store.OrderStatusType
    belongs_to :user, Store.User

    timestamps
  end

  @required_fields ~w(active order_id order_status_type_id user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:active, :order_id, :order_status_type_id, :user_id])
    |> validate_required([:active, :order_id, :order_status_type_id, :user_id])
  end
end
