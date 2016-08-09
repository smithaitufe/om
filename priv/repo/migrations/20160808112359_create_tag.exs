defmodule Store.Repo.Migrations.CreateTag do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :name, :string, null: false
      add :slug, :string, null: false
      add :description, :string

      timestamps
    end

  end
end
