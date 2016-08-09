defmodule Store.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :url, :string
    field :height, :integer
    field :width, :integer
    field :name, :string
    field :position, :integer
    field :caption, :string

    timestamps
  end

  @fields ~w(url height width name position caption)a
  @required_fields ~w(url height width name position caption)a

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
