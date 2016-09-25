defmodule Store.InvoiceType do
  use Ecto.Schema
  import Ecto.Changeset

  schema "invoice_types" do
    field :name, :string
    field :slug, :string

    timestamps
  end

  def invoice_types, do:  ~w(Purchase RMA)

  @fields ~w(name slug)a
  @required_fields ~w(name)a


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> generate_slug()
  end

  defp generate_slug(changeset) do
    if name = get_change(changeset, :name) do
      slug = name
      |> String.downcase()
      |> String.replace(~r/[^\w-]+/, "-")
      put_change(changeset, :slug, slug)
    else
      changeset
    end
  end
end
