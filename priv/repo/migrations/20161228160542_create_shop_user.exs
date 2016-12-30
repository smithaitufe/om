defmodule Store.Repo.Migrations.CreateShopUser do
  use Ecto.Migration

  def change do
    create table(:shop_users, primary_key: false) do
      add :shop_id, references(:shops), primary_key: true
      add :user_id, references(:users)

      timestamps
    end
    create index(:shop_users, [:shop_id])
    create index(:shop_users, [:user_id])

  end
end
