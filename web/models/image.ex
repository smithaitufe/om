defmodule Store.Image do
  use Ecto.Schema

  schema "images" do
    field :url, :string
    field :height, :integer
    field :width, :integer
    field :name, :string
    field :position, :integer
    field :caption, :string

    timestamps
  end

  @required_fields ~w(url height width name position caption)
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
