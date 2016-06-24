defmodule Store.Repo.Migrations.CreateUserAddress do
  use Ecto.Migration

  def change do
    create table(:user_addresses, primary_key: false) do
      add :address_id, references(:addresses), primary_key: true
      add :user_id, references(:users)
      add :active, :boolean, default: false

      timestamps
    end
    create index(:user_addresses, [:user_id])
    create index(:user_addresses, [:address_id])
    

  end
end
