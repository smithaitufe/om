defmodule Store.User do
  use Store.Web, :model

  schema "users" do

    field :last_name, :string
    field :first_name, :string
    field :email, :string
    field :code, :string
    field :hashed_password, :string
    field :active, :boolean, default: false
    field :locked, :boolean, default: false
    field :lock_expires_at, Ecto.DateTime
    field :reset_token, :string
    field :reset_token_created_at, Ecto.DateTime
    field :reset_token_expires_at, Ecto.DateTime
    

    belongs_to :user_type, Store.UserType
    has_many :user_addresses, Store.UserAddress, foreign_key: :user_id

    has_many :carts, Store.Cart
    has_many :cart_items, through: [:carts, :cart]

    timestamps


    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @required_fields [:code, :user_type_id, :last_name, :first_name, :email, :password, :password_confirmation]
  @optional_fields [:active, :locked, :lock_expires_at, :reset_token, :reset_token_created_at, :reset_token_expires_at]

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> hash_password
  end

  defp hash_password(current_changeset) do
    case current_changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} -> put_change(current_changeset, :hashed_password, Comeonin.Bcrypt.hashpwsalt(password))
      _ -> current_changeset
    end
  end

  
end
