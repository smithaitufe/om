defmodule Store.Repo.Migrations.CreateShippingRateType do
  use Ecto.Migration

  def change do
    create table(:shipping_rate_types) do
      add :name, :string, size: 50, null: false

      timestamps
    end

  end
end
