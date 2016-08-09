defmodule Store.UserRole do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_roles" do
    belongs_to :user, Store.User
    belongs_to :role, Store.Role

    timestamps
  end

  @fields ~w(user_id role_id)
  @required_fields ~w(user_id role_id)


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
