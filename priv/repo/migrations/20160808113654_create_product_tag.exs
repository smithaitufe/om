defmodule Store.Repo.Migrations.CreateProductTag do
  use Ecto.Migration

  def change do
    create table(:product_tags) do
      add :product_id, references(:products)
      add :tag_id, references(:tags)

      timestamps
    end
    create index(:product_tags, [:product_id])
    create index(:product_tags, [:tag_id])

  end
end
