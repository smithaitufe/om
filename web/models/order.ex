defmodule Store.Order do
  use Ecto.Schema

  schema "orders" do
    field :number, :string
    field :active, :boolean, default: false
    belongs_to :user, Store.User
    belongs_to :bill_address, Store.Address
    belongs_to :ship_address, Store.Address
    belongs_to :coupon, Store.Coupon

    timestamps
  end

  @required_fields ~w(number active bill_address_id ship_address_id user_id)
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
