defmodule Store.Repo.Migrations.CreatePayment do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :success, :boolean, default: false
      add :cleared, :boolean, default: false
      add :error_code, :string, limit: 10
      add :error, :string
      add :invoice_id, references(:invoices)
      add :payment_method_id, references(:payment_methods)
      add :cleared_by_user_id, references(:users)

      timestamps
    end
    create index(:payments, [:invoice_id])
    create index(:payments, [:payment_method_id])
    create index(:payments, [:cleared_by_user_id])

  end
end
