defmodule Store.TaxRate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tax_rates" do
    field :percentage, :integer
    field :start_date, Timex.Ecto.Date
    field :end_date, Timex.Ecto.Date
    field :active, :boolean
    belongs_to :country, Store.Country

    timestamps
  end

  @fields ~w(country_id percentage start_date end_date active)a
  @required_fields ~w(country_id percentage start_date end_date)a

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
