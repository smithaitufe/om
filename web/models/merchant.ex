defmodule Store.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field :name, :string
    field :phone_number, :string
    field :email, :string

    timestamps
  end

  @fields ~w(name phone_number email)
  @required_fields ~w(name phone_number email)


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
