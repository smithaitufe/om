defmodule Store.Country do
  use Ecto.Schema

  schema "countries" do
    field :name, :string
    field :abbreviation, :string



    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ :empty) do
    struct
    |> cast(params, [:name, :abbreviation])
    |> validate_required([:name, :abbreviation])
  end
end
