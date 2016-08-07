defmodule Store.Cart do
  use Ecto.Schema
  import Ecto.Changeset
  
  schema "carts" do
    belongs_to :user, Store.User

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:user_id])
    |> validate_required([:user_id])
  end
end
