defmodule Store.UserType do
  use Store.Web, :model

  schema "user_types" do
    field :name, :string
    field :description, :string
    field :code, :string

    timestamps
  end

  
  @required_fields [:name, :code]
  @optional_fields  [:description]


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
