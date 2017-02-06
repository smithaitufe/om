defmodule Store.Image do
  use Store.Web, :model

  schema "images" do
    field :name, :string
    field :upload, :any, virtual: true

    has_many :product_images, Store.ProductImage
    
    timestamps()
  end

  @required_fields [:upload]
  @optional_fields []

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
  def attachment_changeset(struct, params \\ %{}) do
    struct
    |> changeset(params)
    |> put_name()
    |> cast(params, [:name])
  end
  def put_name(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{upload: %Plug.Upload{content_type: "image/" <> _, filename: name}}} ->
        put_change(changeset, :name, name)
      _ -> changeset
      
    end
  end
  def store(%Plug.Upload{} = upload, image) do
    Store.Uploader.store({upload, image})
  end
  def store(image_path, image) do
    Store.Uploader.store({image_path, image})
  end
  def url(image, version) do
    Store.Uploader.url({image.name, image}, version)
  end

end
