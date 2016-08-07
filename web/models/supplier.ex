defmodule Store.Supplier do
  use Ecto.Schema

  schema "suppliers" do
    field :name, :string
    field :email, :string
    field :phone_number, :string

    timestamps
  end

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
