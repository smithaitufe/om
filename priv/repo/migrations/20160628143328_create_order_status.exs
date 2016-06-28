defmodule Store.Repo.Migrations.CreateOrderStatus do
  use Ecto.Migration

  def change do
    create table(:order_statuses) do
      add :active, :boolean, default: false
      add :order_id, references(:orders)
      add :order_status_type_id, references(:order_status_types)

      timestamps
    end
    create index(:order_statuses, [:order_id])
    create index(:order_statuses, [:order_status_type_id])

  end
end
