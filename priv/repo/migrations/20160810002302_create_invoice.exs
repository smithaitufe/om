defmodule Store.Repo.Migrations.CreateInvoice do
  use Ecto.Migration

  def change do
    create table(:invoices) do
      add :number, :string, limit: 50, null: false
      add :amount, :decimal, default: 0.0
      add :active, :boolean, default: true
      add :order_id, references(:orders)
      add :invoice_type_id, references(:invoice_types)
      add :invoice_status_id, references(:invoice_statuses)
      add :created_by_user_id, references(:users)

      timestamps
    end
    create index(:invoices, [:order_id])
    create index(:invoices, [:invoice_type_id])
    create index(:invoices, [:invoice_status_id])
    create index(:invoices, [:created_by_user_id])

  end
end
