defmodule Store.InvoiceState do
  use Store.Web, :model

  schema "invoice_states" do
    field :active, :boolean, default: false
    belongs_to :invoice, Store.Invoice
    belongs_to :invoice_status, Store.InvoiceStatus
    belongs_to :user, Store.User

    timestamps
  end

  @required_fields ~w(active)
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
