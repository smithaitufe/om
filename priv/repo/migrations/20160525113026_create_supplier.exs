defmodule Store.Repo.Migrations.CreateSupplier do
  use Ecto.Migration

  def change do
    create table(:suppliers) do
      add :name, :string
      add :email, :string
      add :phone_number, :string

      timestamps
    end

  end
end
