defmodule Store.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :number, :string
    field :active, :boolean, default: false
    belongs_to :user, Store.User
    belongs_to :bill_address, Store.Address
    belongs_to :ship_address, Store.Address
    belongs_to :coupon, Store.Coupon

    timestamps
  end
  @fields ~w(number active bill_address_id ship_address_id user_id)a
  @required_fields ~w(number active bill_address_id ship_address_id user_id)a
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

  def completed_invoices do
  end
  def authorized_invoices do
  end
  def paid_invoices do
  end
  def canceled_invoices do
  end
  
end
