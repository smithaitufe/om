defmodule Store.Repo.Migrations.CreateImage do
  use Ecto.Migration

  def change do
    create table(:images) do
      add :url, :string, limit: 255, null: false, unique: true
      add :height, :integer
      add :width, :integer
      add :name, :string, limit: 150, null: false
      add :position, :integer
      add :caption, :string

      timestamps
    end

  end
end
