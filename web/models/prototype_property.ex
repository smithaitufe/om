defmodule Store.PrototypeProperty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prototype_properties" do
    belongs_to :prototype, Store.Prototype
    belongs_to :property, Store.Property

    timestamps
  end
  @fields ~w(prototype_id property_id)
  @required_fields ~w(prototype_id property_id)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
  end
end
