defmodule Store.Repo.Migrations.CreateInvoiceType do
  use Ecto.Migration

  def change do
    create table(:invoice_types) do
      add :name, :string, limit: 150, null: false
      add :slug, :string, limit: 200, null: false

      timestamps
    end

  end
end
