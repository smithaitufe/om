defmodule Store.Repo.Migrations.CreatePaymentMethod do
  use Ecto.Migration

  def change do
    create table(:payment_methods) do
      add :name, :string, limit: 50, null: false

      timestamps
    end

  end
end
