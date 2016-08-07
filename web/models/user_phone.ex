defmodule Store.UserPhone do
  use Ecto.Schema

  schema "user_phones" do
    field :number,:string, virtual: true
    field :phone_type_id, :integer, virtual: true
    field :primary, :boolean, virtual: true

    belongs_to :phone, Store.Phone
    belongs_to :user, Store.User

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:user_id, :phone_id, :phone_type_id, :number, :primary])
    |> validate_required([:user_id, :phone_id, :phone_type_id, :number, :primary])
  end
end
