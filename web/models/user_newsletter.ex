defmodule Store.UserNewsletter do
  use Ecto.Schema
  import Ecto.Changeset

  schema "user_newsletters" do
    belongs_to :user, Store.User
    belongs_to :newsletter, Store.Newsletter

    timestamps
  end

  @fields ~w(user_id newsletter_id)a
  @required_fields ~w(user_id newsletter_id)a


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
