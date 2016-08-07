defmodule Store.PrototypeProperty do
  use Ecto.Schema

  schema "prototype_properties" do
    belongs_to :prototype, Store.Prototype
    belongs_to :property, Store.Property

    timestamps
  end

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, [:prototype_id, :property_id])
    |> validate_required([:prototype_id, :property_id])
  end
end
