defmodule Store.Repo.Migrations.CreateOrderStatusType do
  use Ecto.Migration

  def change do
    create table(:order_status_types) do
      add :name, :string, null: false

      timestamps
    end

  end
end
