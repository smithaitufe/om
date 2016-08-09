defmodule Store.AddressType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "address_types" do
    field :name, :string
    has_many :addresses, Store.Address
    timestamps
  end

  @fields ~w(name)
  @required_fields ~w(name)


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
