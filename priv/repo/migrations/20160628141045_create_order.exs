defmodule Store.Repo.Migrations.CreateOrder do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :number, :string, null: false
      add :active, :boolean, default: true
      add :user_id, references(:users)
      add :bill_address_id, references(:addresses)
      add :ship_address_id, references(:addresses)
      add :coupon_id, references(:coupons)

      timestamps
    end
    create index(:orders, [:user_id])
    create index(:orders, [:bill_address_id])
    create index(:orders, [:ship_address_id])
    create index(:orders, [:coupon_id])

  end
end
