defmodule Store.UserNewsletter do
  use Ecto.Schema

  schema "user_newsletters" do
    belongs_to :user, Store.User
    belongs_to :newsletter, Store.Newsletter

    timestamps
  end

  @required_fields ~w()
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
