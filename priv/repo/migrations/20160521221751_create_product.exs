defmodule Store.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, size: 255, null: false
      add :short_description, :string
      add :long_description, :text
      add :available_at, :datetime
      add :deleted_at, :datetime
      add :permalink, :string
      add :keywords, :text
      add :featured, :boolean, default: false
      add :product_category_id, references(:product_categories)
      add :shipping_category_id, references(:shipping_categories)

      timestamps
    end
    create index(:products, [:product_category_id])
    create index(:products, [:shipping_category_id])
    create unique_index(:products, [:name])

  end
end
