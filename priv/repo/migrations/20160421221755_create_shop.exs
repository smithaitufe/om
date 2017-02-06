defmodule Store.Repo.Migrations.CreateShop do
  use Ecto.Migration

  def change do
    create table(:shops) do
      add :name, :string, limit: 255, null: false
      add :phone_number, :string, size: 15, null: false
      add :email, :string, size: 100
      add :user_id, references(:users)
      add :slogan, :string
      add :verified, :boolean, default: false
      add :active, :boolean, default: false

      timestamps()
    end
    create index(:shops, [:user_id])

  end
end
