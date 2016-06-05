defmodule Store.User do
  use Store.Web, :model

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

    has_many :shipping_addresses, {"shipping_addresses", Store.Address}, foreign_key: :assoc_id

    timestamps
  end

  @required_fields ~w(last_name first_name email encrypted_password active locked lock_expires_at reset_token reset_token_created_at reset_token_expires_at login_attempts)
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
