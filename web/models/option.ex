defmodule Store.Option do
  use Store.Web, :model

  schema "options" do
    field :name, :string
    belongs_to :option_group, Store.OptionGroup

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required([:name])
  end
end
