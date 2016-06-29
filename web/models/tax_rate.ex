defmodule Store.TaxRate do
  use Store.Web, :model

  schema "tax_rates" do
    field :percentage, :integer
    field :start_date, Timex.Ecto.Date
    field :end_date, Timex.Ecto.Date
    field :active, :boolean
    belongs_to :country, Store.Country

    timestamps
  end

  @required_fields ~w(percentage start_date country_id)
  @optional_fields ~w(active end_date)

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
