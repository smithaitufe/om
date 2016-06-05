defmodule Store.Repo.Migrations.CreateCoupon do
  use Ecto.Migration

  def change do
    create table(:coupons) do
      add :type, :string, null: false
      add :code, :string, null: false
      add :description, :string, null: false
      add :amount, :decimal, precision: 8, scale: 2, default: 0
      add :minimum_value, :decimal, precision: 8, scale: 2
      add :percent, :integer, default: 0
      add :combine, :boolean, default: false
      add :starts_at, :datetime
      add :expires_at, :datetime

      timestamps
    end

    create index(:coupons, [:type])
    create index(:coupons, [:code])

  end
end
