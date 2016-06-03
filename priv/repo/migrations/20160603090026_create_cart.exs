defmodule Store.Repo.Migrations.CreateCart do
  use Ecto.Migration

  def change do
    create table(:carts) do
      add :user_id, references(:users), null: false

      timestamps
    end
    create index(:carts, [:user_id])

  end
end
