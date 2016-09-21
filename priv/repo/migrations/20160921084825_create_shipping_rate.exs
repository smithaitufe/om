defmodule Store.Repo.Migrations.CreateShippingRate do
  use Ecto.Migration

  def change do
    create table(:shipping_rates) do
      add :minimum, :float, default: 0.0, null: false
      add :maximum, :float, default: 0.0, null: false
      add :rate, :decimal, default: 0.0, null: false, precision: 8, scale: 2
      add :active, :boolean, default: false
      add :payment_method_id, references(:payment_methods)
      add :shipping_method_id, references(:shipping_methods)
      add :shipping_rate_type_id, references(:shipping_rate_types)

      timestamps
    end
    create index(:shipping_rates, [:payment_method_id])
    create index(:shipping_rates, [:shipping_method_id])
    create index(:shipping_rates, [:shipping_rate_type_id])

  end
end
