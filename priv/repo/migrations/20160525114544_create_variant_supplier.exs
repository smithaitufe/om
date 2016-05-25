defmodule Store.Repo.Migrations.CreateVariantSupplier do
  use Ecto.Migration

  def change do
    create table(:variant_suppliers) do
      add :cost, :decimal
      add :total_quantity_supplied, :integer
      add :min_quantity, :integer
      add :max_quantity, :integer
      add :active, :boolean, default: false
      add :variant_id, references(:variants)
      add :supplier_id, references(:suppliers)

      timestamps
    end
    create index(:variant_suppliers, [:variant_id])
    create index(:variant_suppliers, [:supplier_id])

  end
end
