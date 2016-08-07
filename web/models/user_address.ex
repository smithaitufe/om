defmodule Store.UserAddress do
  use Ecto.Schema

  schema "user_addresses" do

    field :active, :boolean, default: false
    belongs_to :user, Store.User
    belongs_to :address, Store.Address


    timestamps
  end

  @required_fields ~w(user_id, address_id, active)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:user_id, :address_id, :active])
    |> validate_required([:user_id, :address_id, :active])
  end
end
