defmodule Store.Repo.Migrations.CreateTaxRate do
  use Ecto.Migration

  def change do
    create table(:tax_rates) do
      add :percentage, :integer, null: false
      add :start_date, :date, null: false
      add :end_date, :date, null: true
      add :country_id, references(:countries)
      add :active, :boolean, default: true

      timestamps
    end
    create index(:tax_rates, [:country_id])

  end
end
