defmodule Store.Address do
  use Store.Web, :model

  schema "addresses" do   

    field :address1, :string
    field :address2, :string
    field :city, :string
    field :state_id, :string
    field :country_id, :string
    field :zip_code, :string

    timestamps
  end

  @required_fields ~w(address1 address2 city state_id country_id)
  @optional_fields ~w(zip_code)

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
