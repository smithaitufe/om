defmodule Store.Repo.Migrations.CreateVariant do
  use Ecto.Migration

  def change do
    create table(:variants) do
      add :sku, :string, size: 50, null: false
      add :name, :string, size: 255, null: false
      add :price, :decimal
      add :compare_price, :decimal
      add :master, :boolean, default: false
      add :quantity_on_hand, :integer
      add :quantity_pending_to_customer, :integer
      add :quantity_pending_from_supplier, :integer
      add :deleted_at, :datetime
      add :product_id, references(:products), null: false
      add :image_group_id, references(:image_groups)
      add :weight, :float, default: 0.0, null: false

      timestamps
    end
    create index(:variants, [:product_id])
    create index(:variants, [:image_group_id])
    create unique_index(:variants, [:sku])

  end
end
