defmodule Store.Repo.Migrations.CreateSupplier do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :name, :string, size: 150, null: false
      add :email, :string, size: 150, null: false
      add :phone_number, :string, size: 15, null: false

      timestamps
    end

  end
end
