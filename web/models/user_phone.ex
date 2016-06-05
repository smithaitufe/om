defmodule Store.UserPhone do
  use Store.Web, :model

  schema "user_phones" do
    field :number,:string, virtual: true
    field :phone_type_id, :integer, virtual: true
    field :primary, :boolean, virtual: true

    belongs_to :phone, Store.Phone
    belongs_to :user, Store.User

    timestamps
  end

  @required_fields ~w(user_id phone_id)
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
