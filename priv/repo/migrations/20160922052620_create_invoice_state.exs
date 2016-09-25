defmodule Store.Repo.Migrations.CreateInvoiceState do
  use Ecto.Migration

  def change do
    create table(:invoice_states) do
      add :active, :boolean, default: true
      add :invoice_id, references(:invoices)
      add :invoice_status_id, references(:invoice_statuses)
      add :user_id, references(:users)

      timestamps
    end
    create index(:invoice_states, [:invoice_id])
    create index(:invoice_states, [:invoice_status_id])
    create index(:invoice_states, [:user_id])

  end
end
