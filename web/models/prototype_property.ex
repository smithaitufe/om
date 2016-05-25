defmodule Store.PrototypeProperty do
  use Store.Web, :model

  schema "prototype_properties" do
    belongs_to :prototype, Store.Prototype
    belongs_to :property, Store.Property

    timestamps
  end

  @required_fields ~w(prototype_id property_id)
  @optional_fields ~w()

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
