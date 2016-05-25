defmodule Store.Repo.Migrations.CreateMerchant do
  use Ecto.Migration

  def change do
    create table(:merchants) do
      add :name, :string, size: 150, null: false
      add :phone_number, :string, size: 15, null: false
      add :email, :string, size: 100

      timestamps
    end

  end
end
