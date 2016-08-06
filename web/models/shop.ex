defmodule Store.Shop do
  use Ecto.Schema

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
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
