defmodule Store.Repo.Migrations.CreateOrderStatus do
  use Ecto.Migration

  def change do
    create table(:order_states) do
      add :user_id, references(:users)
      add :order_id, references(:orders)
      add :order_status_id, references(:order_statuses)
      add :active, :boolean, default: true

      timestamps
    end
    create index(:order_statuses, [:order_id])
    create index(:order_statuses, [:user_id])
    create index(:order_statuses, [:order_status_id])

  end
end
