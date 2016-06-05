defmodule Store.UserAddress do
  use Store.Web, :model

  schema "user_addresses" do
    field :default, :boolean, default: false
    field :active, :boolean, default: false
    belongs_to :user, Store.User
    belongs_to :address, Store.Address
    belongs_to :address_type, Store.AddressType

    timestamps
  end

  @required_fields ~w(default active)
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
