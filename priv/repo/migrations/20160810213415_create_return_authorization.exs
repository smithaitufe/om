defmodule Store.Repo.Migrations.CreateReturnAuthorization do
  use Ecto.Migration

  def change do
    create table(:return_authorizations) do
      add :number, :string, limit: 50, null: false
      add :amount, :decimal
      add :restocking_fee, :decimal
      add :active, :boolean, default: false
      add :order_id, references(:orders)
      add :created_by, references(:users)

      timestamps
    end
    create index(:return_authorizations, [:order_id])
    create index(:return_authorizations, [:created_by])

  end
end
