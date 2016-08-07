defmodule Store.TaxRate do
  use Ecto.Schema

  schema "tax_rates" do
    field :percentage, :integer
    field :start_date, Timex.Ecto.Date
    field :end_date, Timex.Ecto.Date
    field :active, :boolean
    belongs_to :country, Store.Country

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:country_id, :percentage, :start_date, :end_date, :active])
    |> validate_required([:country_id, :percentage, :start_date, :end_date])
  end
end
