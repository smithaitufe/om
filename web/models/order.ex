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

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:number, :active, :bill_address_id, :ship_address_id, :user_id])
    |> validate_required([:number, :active, :bill_address_id, :ship_address_id, :user_id])
  end
end
