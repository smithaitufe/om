defmodule Store.Repo.Migrations.CreateImageGroup do
  use Ecto.Migration

  def change do
    create table(:image_groups) do
      add :name, :string, limit: 150, null: false
      add :product_id, references(:products), null: false

      timestamps
    end
    create index(:image_groups, [:product_id])

  end
end
