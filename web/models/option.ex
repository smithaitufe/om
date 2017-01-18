defmodule Store.Option do
  use Store.Web, :model

  schema "options" do
    field :name, :string
    belongs_to :option_group, Store.OptionGroup

    timestamps()
  end

  @required_fields [:option_group_id, :name]
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
