defmodule Store.Repo.Migrations.CreateProduct do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :shop_id, references(:shops)
      add :name, :string, size: 255, null: false
      add :short_description, :text, null: false
      add :long_description, :text
      add :available_at, :datetime
      add :deleted_at, :datetime
      add :permalink, :string, null: false
      add :keywords, :text, null: false
      add :featured, :boolean, default: false
      add :product_category_id, references(:product_categories)
      add :shipping_category_id, references(:shipping_categories)
      add :brand_id, references(:brands)
      add :meta_keywords, :text
      add :meta_description, :text

      timestamps
    end
    create index(:products, [:product_category_id])
    create index(:products, [:shipping_category_id])
    create index(:products, [:brand_id])
    create unique_index(:products, [:name])

  end
end
