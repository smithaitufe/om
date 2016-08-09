defmodule Store.Phone do
  use Ecto.Schema
  import Ecto.Changeset

  schema "phones" do
    field :number, :string
    belongs_to :phone_type, Store.PhoneType
    field :primary, :boolean, default: false

    timestamps
  end

  @fields ~w(number phone_type_id primary)a
  @required_fields ~w(number phone_type_id)a


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
