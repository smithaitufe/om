defmodule Store.Repo.Migrations.CreateUserPhone do
  use Ecto.Migration

  def change do
    create table(:user_phones, primary_key: false) do
      add :phone_id, references(:phones), primary_key: true
      add :user_id, references(:users)

      timestamps
    end
    create index(:user_phones, [:phone_id])
    create index(:user_phones, [:user_id])

  end
end
