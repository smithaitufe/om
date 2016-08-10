defmodule Store.Repo.Migrations.CreateOrderStatus do
  use Ecto.Migration

  def change do
    create table(:order_statuses) do
      add :name, :string, null: false

      timestamps
    end

  end
end
