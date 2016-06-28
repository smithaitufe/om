defmodule Store.OrderStatus do
  use Store.Web, :model

  schema "order_statuses" do
    field :active, :boolean, default: false
    belongs_to :order, Store.Order
    belongs_to :order_status_type, Store.OrderStatusType

    timestamps
  end

  @required_fields ~w(active)
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
