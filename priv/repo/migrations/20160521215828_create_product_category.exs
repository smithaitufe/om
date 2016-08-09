defmodule Store.Repo.Migrations.CreateProductCategory do
  use Ecto.Migration

  def change do
    create table(:product_categories) do
      add :name, :string, null: false
      add :description, :string, size: 100
      add :active, :boolean, default: false
      add :parent_id, references(:product_categories)
      add :slug, :string, null: false

      timestamps
    end
    create index(:product_categories, [:parent_id])

  end
end
