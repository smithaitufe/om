defmodule Store.Merchant do
  use Ecto.Schema
  import Ecto.Changeset

  schema "merchants" do
    field :name, :string
    field :phone_number, :string
    field :email, :string

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
    |> cast(params, [:name, :phone_number, :email])
    |> validate_required([:name, :phone_number, :email])
  end
end
