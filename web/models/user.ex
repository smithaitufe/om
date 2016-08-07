defmodule Store.User do
  use Ecto.Schema

  schema "users" do

    field :last_name, :string
    field :first_name, :string
    field :email, :string
    field :encrypted_password, :string
    field :active, :boolean, default: false
    field :locked, :boolean, default: false
    field :lock_expires_at, Ecto.DateTime
    field :reset_token, :string
    field :reset_token_created_at, Ecto.DateTime
    field :reset_token_expires_at, Ecto.DateTime
    field :login_attempts, :integer

    belongs_to :user_type, Store.UserType
    has_many :user_addresses, Store.UserAddress, foreign_key: :user_id

    timestamps


    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:user_type_id, :last_name, :first_name, :email, :encrypted_password, :active, :locked, :lock_expires_at, :reset_token, :reset_token_created_at, :reset_token_expires_at, :login_attempts])
    |> validate_required([:user_type_id, :last_name, :first_name, :email, :password, :password_confirmation])
  end
end
