defmodule Store.Repo.Migrations.CreateVariant do
  use Ecto.Migration

  def change do
    create table(:variants) do
      add :sku, :string
      add :name, :string
      add :price, :decimal
      add :compare_price, :decimal
      add :master, :boolean, default: false
      add :quantity_on_hand, :integer
      add :quantity_pending_to_customer, :integer
      add :quantity_pending_from_supplier, :integer
      add :deleted_at, :datetime
      add :product_id, references(:products)

      timestamps
    end
    create index(:variants, [:product_id])

  end
end
