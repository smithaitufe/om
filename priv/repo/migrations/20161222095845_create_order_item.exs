defmodule Store.Repo.Migrations.CreateOrderItem do
  use Ecto.Migration

  def change do
    create table(:order_items) do
      add :price, :decimal
      add :quantity, :integer
      add :total, :decimal
      add :state, :string
      add :order_id, references(:orders)
      add :variant_id, references(:variants)

      timestamps
    end
    create index(:order_items, [:order_id])
    create index(:order_items, [:variant_id])

  end
end
