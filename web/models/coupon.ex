defmodule Store.Coupon do
  use Store.Web, :model

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

  @required_fields ~w(type code description amount minimum_value percent combine starts_at expires_at)
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
