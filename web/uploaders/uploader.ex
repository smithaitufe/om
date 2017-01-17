defmodule Store.Uploader do
  use Arc.Definition

  # Include ecto support (requires package arc_ecto installed):
  # use Arc.Ecto.Definition
  @acl :public_read
  @height %{show: 315, thumb: 40, slide: 250}
  @versions [:original, :thumb, :show, :slide]

  # Whitelist file extensions:
  def validate({file, _}) do
    ~w(.jpg .jpeg .gif .png) |> Enum.member?(Path.extname(file.file_name))
  end

  # Define a thumbnail transformation:
  def transform(:thumb, _) do
    {:convert, "-strip -thumbnail x#{@height[:thumb]}^ -gravity center -extent x#{@height[:thumb]} -format png", :png}
  end
  def transform(:show, _) do
    {:convert, "-strip -resize x#{@height[:show]}^ -gravity center -extent x#{@height[:show]} -format png", :png}
  end
  def transform(:slide, _) do
    {:convert, "-strip -resize x#{@height[:slide]}^ -gravity center -extent x#{@height[:slide]} -format png", :png}
  end
  

  # Override the persisted filenames:
  def filename(version, {file, _}) do
    Path.rootname("#{version}_#{file.file_name}")
  end
  # using local storage
  # def __storage, do: Arc.Storage.Local
  
  # Override the storage directory:
  def storage_dir(version, {_, image}) do
    # "uploads/user/avatars/#{scope.id}"
    # "om/files/media/#{image.id}/versions/#{image.id}/#{version}"
    "om/files/media/#{image.id}/versions"
  end

  # Provide a default URL if there hasn't been a file uploaded
  # def default_url(version, scope) do
  #   "/images/avatars/default_#{version}.png"
  # end

  # Specify custom headers for s3 objects
  # Available options are [:cache_control, :content_disposition,
  #    :content_encoding, :content_length, :content_type,
  #    :expect, :expires, :storage_class, :website_redirect_location]
  #
  # def s3_object_headers(version, {file, scope}) do
  #   [content_type: Plug.MIME.path(file.file_name)]
  # end
end
