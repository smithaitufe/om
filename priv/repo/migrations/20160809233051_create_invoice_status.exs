defmodule Store.Repo.Migrations.CreateInvoiceStatus do
  use Ecto.Migration

  def change do
    create table(:invoice_statuses) do
      add :name, :string, limit: 50, null: false

      timestamps
    end

  end
end
