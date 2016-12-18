defmodule Store.Address do
  use Store.Web, :model


  schema "addresses" do
    field :last_name, :string
    field :first_name, :string
    field :address1, :string
    field :address2, :string
    field :phone_number, :string
    field :alternative_phone_number, :string
    field :city_id, :integer
    field :zip_code, :string
    field :default, :boolean, default: false
    belongs_to :address_type, Store.AddressType

    timestamps
  end

  @fields ~w(address_type_id last_name first_name address1 city_id phone_number alternative_phone_number zip_code)a
  @required_fields ~w(address_type_id last_name first_name address1 city_id phone_number)a


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
