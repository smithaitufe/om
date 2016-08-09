defmodule Store.UserPhone do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_phones" do

    belongs_to :phone, Store.Phone
    belongs_to :user, Store.User

    timestamps
  end

  @fields ~w(phone_id user_id)a
  @required_fields ~w(phone_id user_id)a
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
