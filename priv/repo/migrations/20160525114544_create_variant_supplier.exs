defmodule Store.Repo.Migrations.CreateVariantSupplier do
  use Ecto.Migration

  def change do
    create table(:variant_suppliers) do
      add :cost, :decimal, precision: 8, scale: 2, default: 0.0, null: false
      add :total_quantity_supplied, :integer
      add :min_quantity, :integer, null: false, default: 1
      add :max_quantity, :integer, null: false, default: 10000
      add :active, :boolean, default: true
      add :variant_id, references(:variants)
      add :supplier_id, references(:suppliers)

      timestamps
    end
    create index(:variant_suppliers, [:variant_id])
    create index(:variant_suppliers, [:supplier_id])

  end
end
