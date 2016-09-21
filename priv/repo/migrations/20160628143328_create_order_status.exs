defmodule Store.Repo.Migrations.CreateOrderStatus do
  use Ecto.Migration

  def change do
    create table(:order_statuses) do
      add :user_id, references(:users)
      add :order_id, references(:orders)
      add :order_status_type_id, references(:order_status_types)
      add :active, :boolean, default: true

      timestamps
    end
    create index(:order_statuses, [:order_id])
    create index(:order_statuses, [:user_id])
    create index(:order_statuses, [:order_status_type_id])

  end
end
