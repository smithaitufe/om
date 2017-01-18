defmodule Store.OptionGroup do
  use Store.Web, :model

  schema "option_groups" do
    belongs_to :shop, Store.Shop
    field :name, :string

    timestamps()
  end

  @required_fields [:shop_id, :name]
  @optional_fields []

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
