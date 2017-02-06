defmodule Store.Property do
  use Store.Web, :model

  schema "properties" do
    field :display_name, :string
    field :identifying_name, :string
    field :active, :boolean, default: true
    belongs_to :shop, Store.Shop

    timestamps()
  end

  @required_fields [:shop_id, :display_name, :identifying_name]
  @optional_fields [:active]


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
  end
end
