defmodule Store.Address do
  use Store.Web, :model


  schema "addresses" do

    field :last_name, :string
    field :first_name, :string
    field :address, :string
    field :phone_number, :string
    field :alternative_phone_number, :string
    
    field :zip_code, :string
    field :default, :boolean, default: false
    field :landmark, :string   
    field :billing, :boolean, default: false

    belongs_to :user, Store.User
    belongs_to :city, Store.City

    timestamps
  end

  @required_fields [:user_id, :last_name, :first_name, :address, :city_id, :phone_number]
  @optional_fields [:billing, :alternative_phone_number, :zip_code, :landmark]


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end

  def associations do    
    [{:city, :state}]
  end
end
