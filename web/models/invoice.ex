defmodule Store.Invoice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invoices" do
    field :number, :string
    field :amount, :decimal
    field :active, :boolean, default: true
    belongs_to :order, Store.Order
    belongs_to :invoice_type, Store.InvoiceType
    belongs_to :invoice_status, Store.InvoiceStatus
    belongs_to :created_by_user, Store.CreatedByUser

    timestamps
  end

  @fields ~w(invoice_type_id invoice_status_id order_id created_by_user_id number amount active)a
  @required_fields ~w(invoice_type_id invoice_status_id order_id created_by_user_id amount active)a


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
