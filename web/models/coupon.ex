defmodule Store.Coupon do
  use Ecto.Schema
  import Ecto.Changeset

  schema "coupons" do
    field :type, :string
    field :code, :string
    field :description, :string
    field :amount, :decimal
    field :minimum_value, :decimal
    field :percent, :integer
    field :combine, :boolean, default: false
    field :starts_at, Ecto.DateTime
    field :expires_at, Ecto.DateTime

    timestamps
  end

  @fields ~w(type code description amount minimum_value percent combine starts_at expires_at)
  @required_fields ~w(type code description amount minimum_value percent combine starts_at expires_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
