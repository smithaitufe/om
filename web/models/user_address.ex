defmodule Store.UserAddress do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_addresses" do

    field :active, :boolean, default: false
    belongs_to :user, Store.User
    belongs_to :address, Store.Address


    timestamps
  end

  @fields ~w(user_id, address_id, active)
  @required_fields ~w(user_id, address_id)


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
end
