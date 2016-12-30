defmodule Store.Shop do
  use Store.Web, :model

  schema "shops" do
    field :name, :string
    field :phone_number, :string
    field :email, :string
    belongs_to :user, Store.User
    has_many :products, Store.Product
    timestamps


  end

  @required_fields [:user_id, :name, :phone_number]
  @optional_fields [:email]


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
end
