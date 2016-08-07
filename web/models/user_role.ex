defmodule Store.UserRole do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_roles" do
    belongs_to :user, Store.User
    belongs_to :role, Store.Role

    timestamps
  end

  @required_fields ~w(user_id role_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:user_id, :role_id])
    |> validate_required([:user_id, :role_id])
  end
end
