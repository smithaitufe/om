defmodule Store.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :name, :string
    field :phone_number, :string
    field :email, :string
    belongs_to :user, Store.User

    timestamps
  end

  @required_fields ~w(name phone_number email)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:user_id, :name, :phone_number, :email])
    |> validate_required([:user_id, :name, :phone_number, :email])
  end
end
