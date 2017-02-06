defmodule Store.Prototype do
  use Store.Web, :model

  schema "prototypes" do

    field :name, :string
    field :active, :boolean, default: true
    belongs_to :shop, Store.Shop

    has_many :prototype_properties, Store.PrototypeProperty
    has_many :properties, through: [:prototype_properties, :property]
    
    timestamps()
  end

  @required_fields [:shop_id, :name]
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

  def associations do
    [:properties]
  end
end
