defmodule Store.Shop do
  use Ecto.Schema
  import Ecto.Changeset

  schema "shops" do
    field :name, :string
    field :phone_number, :string
    field :email, :string
    belongs_to :user, Store.User
    has_many :products, Store.Product
    timestamps


  end

  @fields ~w(user_id name phone_number email)
  @required_fields ~w(user_id name phone_number email)


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
