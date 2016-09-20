defmodule Store.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "payments" do
    field :success, :boolean, default: false
    field :cleared, :boolean, default: false
    field :error_code, :string
    field :error, :string
    belongs_to :invoice, Store.Invoice
    belongs_to :payment_method, Store.PaymentMethod
    belongs_to :cleared_by_user, Store.ClearedByUser

    timestamps
  end

  @fields ~w(invoice_id payment_method_id success error_code error cleared cleared_by_user_id)a
  @required_fields ~w(invoice_id payment_method_id)a


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ %{}) do
    model
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
