defmodule Store.ReturnAuthorization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "return_authorizations" do
    field :number, :string
    field :amount, :decimal
    field :restocking_fee, :decimal
    field :active, :boolean, default: false
    belongs_to :order, Store.Order
    belongs_to :author, Store.User, foreign_key: :created_by

    timestamps
  end

  @fields ~w(order_id number amount restocking_fee active created_by)a
  @required_fields ~w(order_id number amount restocking_fee created_by)a


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
