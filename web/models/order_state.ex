defmodule Store.OrderState do
  use Ecto.Schema
  import Ecto.Changeset

  schema "order_states" do
    field :active, :boolean, default: false
    belongs_to :order, Store.Order
    belongs_to :order_status, Store.OrderStatus
    belongs_to :user, Store.User

    timestamps
  end

  @fields ~w(active order_id order_status_id user_id)a
  @required_fields ~w(active order_id order_status_id user_id)a


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end